(function($){
	$(document).ready(function(){
	  var fields = 64;	
	  var counter = 0;
	  var output = "";
	  var checkOdd = false;

	  while (counter < fields){
	  	if(counter % 2 == 0 && !checkOdd){
          output += "<div class='square black'></div>";
	  	}
	  	else if(counter % 2 != 0 && checkOdd){
          output += "<div class='square black'></div>";
	  	}
	  	else{
	  	  output += "<div class='square'></div>";
	  	}
	  	counter += 1;
        if(counter % 8 == 0){
          output += "<br/>";
          if(checkOdd){checkOdd = false;}
          else{checkOdd = true;}
        }
	  }
	  $('#chessboard').html(output);
	});
}($));

