(function($){
	$(document).ready(function(){
	      var calc_string = "";
            getCommaEvent();


            // Setting click events for operators and numbers
            $('.button').each(function(index){
                  $(this).on("click", function(){
                        lastChar = calc_string.charAt(calc_string.length-1);

                        // case for numbers  
                        if(!isNaN($(this).attr("name"))){
                              calc_string += $(this).attr("name"); 
                        }

                        // case for operators except comma
                        else{
                              if (lastChar && lastChar != " "){
                                    calc_string += " " + $(this).attr("name") + " "; 
                                    getCommaEvent();
                              }
                        }
                        $('#calc_input').val(calc_string);
                  });
            });

            //Clearing input
            $('#loesche').click(function(event){
                  calc_string = "";
                  $('#calc_input').val(calc_string);
                  getCommaEvent();
                  
            });

            // Submit event (Handling Ajax Post Request)
            $('#submit').click(function(event){
                  event.preventDefault();
                  var request = postAjaxRequest();

                  request.done(function(){
                        var response = request.responseText;
                        
                        if (response=="ERROR"){
                              calc_string = "ERROR";
                        }
                        else{
                            calc_string = parseFloat(response).toFixed(2);  
                        }
                        $('#calc_input').val(calc_string);
                        removeCommaEvent();

                  });
            });

            // Comma event functions
            function getCommaEvent(){
                  $('#comma').click(function(event){
                        lastChar = calc_string.charAt(calc_string.length-1);
                        if (lastChar && lastChar != " " && lastChar != "."){
                              calc_string += ".";
                              $('#calc_input').val(calc_string);
                              removeCommaEvent();
                        }
                  });
            }

            function removeCommaEvent(){
                  $('#comma').off('click');
            }

            

            // Ajax Post Request
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