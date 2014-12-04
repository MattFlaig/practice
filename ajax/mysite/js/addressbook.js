(function($){
  $(document).ready(function(){

    $('#addressbook').click(function(event){
      event.preventDefault();
      $('#boxcontent').children().remove();
      

      var addressContent = "<form id='form' action='#'><h1>Your addressbook</h1><br/>"+
      "<p><label for='firstname'>First Name:</label><input type='text'"+
      "name='firstname' id='firstname'></input></p><p><label for='lastname'>"+
      "Last Name:</label><input type='text' name='lastname' id='lastname'>" +
      "</input></p><p><label for='email'>Email Address:</label><input type='email'" +
      " name='email' id='email'></input></p><p><label for='phone'>Phone Number: </label>" + 
      "<input type='tel' name='phone'+id='phone'></input></p><br/><p><input type='submit'"+
      "class='button' id='show' value='Show'><input type='submit' class='button' id='next'"+
      "value='Next'><input type='submit' class='button' id='back' value='Back'>" + 
      "<input type='submit' class='button' id='new' value='New'>" + 
      "<input type='submit' class='button' id='edit' value='Edit'></p></form>";

      $('#boxcontent').html(addressContent);
    });

  });
}($));













