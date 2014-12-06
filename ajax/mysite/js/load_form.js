(function($){
  $(document).ready(function(){

    $('#loadform').click(function(event){
      event.preventDefault();
      clearOldContent();
      var formContent = getForm();
      $('#boxcontent').html(formContent);

      //function to organize form creation
      function getForm(){
        var form = $('<form/>', {'id':'form','action':'#'});
        $('<h1/>',{'text':'Please fill in the form!'}).appendTo(form);

        var firstParagraph = $(getFormParagraph('name', 'Full Name', 'text')).appendTo(form);
        var secondParagraph = $(getFormParagraph('email', 'Email Address', 'email')).appendTo(form);
        var thirdParagraph = $(getFormParagraph('phone', 'Phone Number', 'tel')).appendTo(form);

        var fourthParagraph = $(getRadioButtons()).appendTo(form);
        var fifthParagraph = $(getCheckBoxes()).appendTo(form);
        var submitButton = $(getSubmitButton()).appendTo(form);

        return form;
      }

      //function for creating form paragraphs with text, email, tel input
      function getFormParagraph(element, elementText, elementType){
        var paragraph = $('<p/>');
        $('<label/>', {'for':element, 'text':elementText}).appendTo(paragraph);
        $('<input/>', {'type':elementType, 'name':element, 'id':element}).appendTo(paragraph);
        return paragraph;
      }

      //function for creating submit button
      function getSubmitButton(){
        var paragraph = $('<p/>');
        $('<input/>', {'type':'submit', 'class':'button','id':'show_table', 'value':'Show'}).appendTo(paragraph);
        return paragraph;
      }

      //function for creating RadioButtons
      function getRadioButtons(){
        var paragraph = $('<p/>');
        $('<label/>', {'for':'gender', 'text':'Gender:'}).appendTo(paragraph);
        $("<input type='radio' name='gender' value='male' checked>Male</input>").appendTo(paragraph);
        $("<input type='radio' name='gender' value='female'>Female</input>").appendTo(paragraph);
        return paragraph;
      }

      //functions for creating CheckBoxes
      function getCheckBoxes(){
        var paragraph = $('<p/>');
        $('<label/>', {'for':'interests', 'text':'Your Interests: (Check all that apply)'}).appendTo(paragraph);
        var table = $('<table/>').appendTo(paragraph);
        var firstRow = $(getCheckBoxRow('sports', 'Sports', 'art', 'Art')).appendTo(table);
        var secondRow = $(getCheckBoxRow('programming', 'Programming', 'philosophy', 'Philosophy')).appendTo(table);
        var thirdRow = $(getCheckBoxRow('music', 'Music', 'nature', 'Nature')).appendTo(table);
        return paragraph;
      }

      function getCheckBoxRow(value1, text1, value2, text2){
        var row = $('<tr/>');
        $("<td><input type='checkbox'name='interests' value="+ value1 +">" + text1+ "</td>").appendTo(row);
        $("<td><input type='checkbox'name='interests' value="+ value2 +">" + text2+ "</td>").appendTo(row);
        return row;
      }

      //function for creating output in a table below the form
      if ($('#form').children().length > 0){
        $('#show_table').click(function(event){
          event.preventDefault();
          //getting all values in a serialized string
          var values = $('#form').serialize();
          var output = "";

          output += "<table>";
          //looping over the values to display them in the table
          $.each(values.split('&'), function (index, elem) {
            var vals = elem.split('=');
            output += "<tr><td>" + vals[0] +":" + "</td><td>" + vals[1] + "</td></tr>";
          });
          output += "</table>";

          //for UTF-8 in jquery
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
