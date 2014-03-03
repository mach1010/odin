$(document).ready(function() {
	
	$("#enter_button").click(
		function() {
		var gridSize = $('#grid_size').val();
		 for(var i=1; i<=gridSize; i++) {
			$('.grid').append('<div class="dot begin"></div>');
		  for(var j=1; j<gridSize; j++) {
		  	$('.grid').append('<div class="dot"></div>');
		  }
		 }
		}
	);
	
	$("#reset_button").click(function() {
		$('.grid').empty();
	});

	$('.grid').on({
		mouseenter: function() { $(this).addClass('dot_on'); }, 
		//mouseleave: function() { $(this).removeClass('red');}
	}, "div");
	
});