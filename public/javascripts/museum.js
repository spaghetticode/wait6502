$(function(){
	$('#search input[type=submit]').hide();
	$('#search #query').click(function(){if($(this).val() == 'search'){$(this).val('');}}).blur(function(){if ('' == $(this).val()) {$(this).val('search')}}); 
})