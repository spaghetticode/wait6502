  jQuery.ajaxSetup({
  	'beforeSend': function(xhr){xhr.setRequestHeader('Accept', 'text/javascript')}
  })

  $(function(){
  	$('.price .button-to').submit(function(){
  		$.post($(this).attr('action'), $(this).serialize(), null, 'script');
		var spinner = '<img src="/images/spinner.gif" style="margin-right:15px"/>';
  		$(this).parent().html(spinner);
  		return false;
  	})
	$('.destroy .button-to').click(function(){
		if (confirm('are you sure?')) {
  			$.post($(this).attr('action'), $(this).serialize(), null, 'script');
		}
		return false;
	})
  })