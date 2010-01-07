$(function(){
	$('#search input[type=submit]').hide();
	$('#search #query').click(function(){$(this).val('');}).blur(function(){if ('' == $(this).val()) {$(this).val('search')}}); 
})