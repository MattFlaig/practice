(function($){
  $(document).ready(function(){

    $('#loadform').click(function(event){
      event.preventDefault();
      clearOldContent();

      var formContent = "<form id='form' action='#'><h1>Please fill in the form!</h1>" +
      "<br/><p><label for='name'>Full Name:</label><input type='text' name='name' id='name'>" +
      "</input></p><p><label for='email'>Email Address: </label><input type='email' name='email'" +
      "id='email'></input></p><p><label for='phone'>Phone Number: </label><input type='tel'" +
      "name='phone' id='phone'></input></p><p><label for='gender'>Gender: </label>" +
      "<input type='radio' name='gender' value='male' checked>Male</input><input type='radio'" +
      "name='gender' value='female'>Female</input></p><br/><p><label for='interests'>" + 
      "Your Interests: (Check all that apply) </label><table><tr><td><input type='checkbox'" +
      "name='interests' value='sports'>Sports</td><td><input type='checkbox' name='interests'" +
      "value='art'>Art</td></tr><tr><td><input type='checkbox' name='interests' value='programming'>" +
      "Programming</td><td><input type='checkbox' name='interests' value='philosophy'>Philosophy</td>" +
      "</tr><tr><td><input type='checkbox' name='interests' value='music'>Music</td>" + 
      "<td><input type='checkbox' name='interests' value='nature'>Nature</td></tr></table>" +
      "</p><br/><p><input type='submit' class='button' id='show_table' value='Show'></p></form>";

      $('#boxcontent').html(formContent);

      if ($('#form').children().length > 0){
        $('#show_table').click(function(event){
          event.preventDefault();
          var values = $('#form').serialize();
          var output = "";

          output += "<table>";
          $.each(values.split('&'), function (index, elem) {
            var vals = elem.split('=');
            output += "<tr><td>" + vals[0] +":" + "</td><td>" + vals[1] + "</td></tr>";
          });
          output += "</table>";

          var decodedOutput = decodeURIComponent(output);
          $('#output').addClass("output_table");
          $('#output').html(decodedOutput);
        });
      }

      function clearOldContent(){
        $('#boxcontent').children().remove();
        $('#output').children().remove();
        $('#output').removeClass('output_table');
        $('#output').removeClass('output_contact');
      };
    });

  });
}($));
