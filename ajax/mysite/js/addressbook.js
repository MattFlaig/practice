(function($){
  $(document).ready(function(){

    $('#addressbook').click(function(event){
      event.preventDefault();
      clearOldContent();
      
      var addressContent = "<form id='form' action='#'><h1>Your addressbook</h1><br/>"+
      "<p><label for='firstname'>First Name:</label><input type='text'"+
      "name='firstname' id='firstname'></input></p><p><label for='lastname'>"+
      "Last Name:</label><input type='text' name='lastname' id='lastname'>" +
      "</input></p><p><label for='email'>Email Address:</label><input type='email'" +
      " name='email' id='email'></input></p><p><label for='phone'>Phone Number: </label>" + 
      "<input type='tel' name='phone' id='phone'></input></p><br/><p><input type='submit'"+
      "class='button' id='show' value='Show'><input type='submit' class='button' id='next'"+
      "value='Next'><input type='submit' class='button' id='back' value='Back'>" + 
      "<input type='submit' class='button' id='new' value='New'>" + 
      "<input type='submit' class='button' id='edit' value='Edit'></p></form>";

      $('#boxcontent').html(addressContent);


      var index = 0;

      $('#show').click(function(event){
        event.preventDefault();
        var request = getAjaxRequest();
        request.done(function(){
          var jsonObject = $.parseJSON(request.responseText);
          $('#firstname').val(jsonObject[0].firstname);
          $('#lastname').val(jsonObject[0].lastname);
          $('#email').val(jsonObject[0].email);
          $('#phone').val(jsonObject[0].phone);
        })
      });


      $('#next').click(function(event){
        event.preventDefault();
        var request = getAjaxRequest();
        request.done(function(){
          var jsonObject = $.parseJSON(request.responseText);
          if(index+1 != jsonObject.length){
            index += 1;
          }
            $('#firstname').val(jsonObject[index].firstname);
            $('#lastname').val(jsonObject[index].lastname);
            $('#email').val(jsonObject[index].email);
            $('#phone').val(jsonObject[index].phone);
        })
      }); 


      $('#back').click(function(event){
        event.preventDefault();
        var request = getAjaxRequest();
        request.done(function(){
          var jsonObject = $.parseJSON(request.responseText);
          if(index != 0){
            index -= 1;
          }
            $('#firstname').val(jsonObject[index].firstname);
            $('#lastname').val(jsonObject[index].lastname);
            $('#email').val(jsonObject[index].email);
            $('#phone').val(jsonObject[index].phone);
        })
      }); 

      function getAjaxRequest(){
          var request = $.ajax({
              type: "GET",
              url: "data/crud.json",
              datatype: "json"
          });
          return request;
      };

      function clearOldContent(){
        $('#boxcontent').children().remove();
        $('#output').children().remove();
        $('#output').removeClass('output_table');
        $('#output').removeClass('output_contact');
      };

    });

  });
}($));













