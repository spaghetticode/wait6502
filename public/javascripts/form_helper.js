$(function(){
	var form_div = $('div#price_form')
	var help_us = $('a#help_us')
	var form = $('#add_price_form')
	form_div.hide();
	$('#message').hide();

	help_us.click(function(){
		$('div#price_form').fadeIn();
		return false;
	})
	
	form.submit(function(){
		$.post($(this).attr('action') + '.js', $(this).serialize(), null, 'script')
		return false;
	})
})