(function($){
	$(document).ready(function(){
	  var calc_string = "";
      // var content = getCalculator();

      // var calc_input = $('#calc_input').val();
      // $('#calculator').html(content);


      $('#plus').click(function(event){
      	event.preventDefault();
            lastChar = calc_string.charAt(calc_string.length-1);
      	if (lastChar != " "){
      		calc_string += " + ";
      		$('#calc_input').val(calc_string);
      	}
      	else{
      		$('#calc_input').val("ERROR");
      	}
      });
      $('#minus').click(function(event){
      	event.preventDefault();
            lastChar = calc_string.charAt(calc_string.length-1);
            if (lastChar != " "){
      		calc_string += " - ";
      		$('#calc_input').val(calc_string);
      	}
      	else{
      		$('#calc_input').val("ERROR");
      	}
      });
      $('#mal').click(function(event){
      	event.preventDefault();
            lastChar = calc_string.charAt(calc_string.length-1);
            if (lastChar != " "){
      		calc_string += " * ";
      		$('#calc_input').val(calc_string);
      	}
      	else{
      		$('#calc_input').val("ERROR");
      	}	
      });
      $('#geteilt').click(function(event){
      	event.preventDefault();
            lastChar = calc_string.charAt(calc_string.length-1);
            if (lastChar != " "){
      		calc_string += " / ";
      		$('#calc_input').val(calc_string);
      	}
      	else{
      		$('#calc_input').val("ERROR");
      	}
      });
      $('#komma').click(function(event){
            event.preventDefault();
            lastChar = calc_string.charAt(calc_string.length-1);
            if (lastChar != " "){
                  calc_string += ".";
                  $('#calc_input').val(calc_string);
            }
            else{
                  $('#calc_input').val("ERROR");
            }
      });
      $('#loesche').click(function(event){
            event.preventDefault();
            calc_string = "";
            $('#calc_input').val(calc_string);
            
      });
      $('#modulo').click(function(event){
            event.preventDefault();
            lastChar = calc_string.charAt(calc_string.length-1);
            if (lastChar != " "){
                  calc_string += " % ";
                  $('#calc_input').val(calc_string);
            }
            else{
                  $('#calc_input').val("ERROR");
            }
      });





      $('#eins').click(function(event){
      	event.preventDefault();
      	calc_string += "1";
      	$('#calc_input').val(calc_string);
      });
      $('#zwei').click(function(event){
      	event.preventDefault();
      	calc_string += "2";
      	$('#calc_input').val(calc_string);
      });
      $('#drei').click(function(event){
      	event.preventDefault();
      	calc_string += "3";
      	$('#calc_input').val(calc_string);
      });
      $('#vier').click(function(event){
      	event.preventDefault();
      	calc_string += "4";
      	$('#calc_input').val(calc_string);
      });
      $('#fuenf').click(function(event){
      	event.preventDefault();
      	calc_string += "5";
      	$('#calc_input').val(calc_string);
      });
      $('#sechs').click(function(event){
      	event.preventDefault();
      	calc_string += "6";
      	$('#calc_input').val(calc_string);
      });
      $('#sieben').click(function(event){
      	event.preventDefault();
      	calc_string += "7";
      	$('#calc_input').val(calc_string);
      });
      $('#acht').click(function(event){
      	event.preventDefault();
      	calc_string += "8";
      	$('#calc_input').val(calc_string);
      });
      $('#neun').click(function(event){
            event.preventDefault();
            calc_string += "9";
            $('#calc_input').val(calc_string);
      });
      $('#null').click(function(event){
            event.preventDefault();
            calc_string += "0";
            $('#calc_input').val(calc_string);
      });


      $('#submit').click(function(event){
            event.preventDefault();
            var request = postAjaxRequest();

            request.done(function(){
              var response = request.responseText;
              $('#calc_input').val(response);
            });
      });

      function postAjaxRequest(){
            var request = $.ajax({
              type: "POST",
              url: "php/rechner.php",
              data: $('form').serialize()
              
            });
            return request;
      }


	});

}($));