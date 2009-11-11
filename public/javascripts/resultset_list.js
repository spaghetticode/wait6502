  jQuery.ajaxSetup({
  	'beforeSend': function(xhr){xhr.setRequestHeader('Accept', 'text/javascript')}
  })

  $(function(){
  	$('form').submit(function(){
  		$.post($(this).attr('action'), $(this).serialize(), null, 'script');
  		$(this).hide();
		var spinner = '<img id="spinner" src="/images/spinner.gif" />';
  		$(this).parent().append(spinner);
  		return false;
  	})
  })