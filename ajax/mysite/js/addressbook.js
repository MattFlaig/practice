(function($){
  $(document).ready(function(){

    // Event Handler for Addressbook link in Header
    $('#addressbook').click(function(event){
      event.preventDefault();//prevent redirect

      // calling function for deleting old template content
      clearOldContent();

      // calling functions to create the form and filling the template 
      var addressContent = getForm();
      $('#boxcontent').html(addressContent);
      
      //Creating form with jquery
      function getForm(){
        var form = $('<form/>', {'id':'form','action':'#'});
        $('<h1/>',{'text':'Your addressbook'}).appendTo(form);

        var firstParagraph = $(getFormParagraph('firstname', 'First Name', 'text')).appendTo(form);
        var secondParagraph = $(getFormParagraph('lastname', 'Last Name', 'text')).appendTo(form);
        var thirdParagraph = $(getFormParagraph('email', 'Email Address', 'email')).appendTo(form);
        var fourthParagraph = $(getFormParagraph('phone', 'Phone Number', 'tel')).appendTo(form);
        
        var submitParagraph = $(getSubmitParagraph()).appendTo(form);

        return form;
      }

      //function for creating addressbook form paragraphs
      function getFormParagraph(element, elementText, elementType){
        var paragraph = $('<p/>');
        $('<label/>', {'for':element, 'text':elementText}).appendTo(paragraph);
        $('<input/>', {'type':elementType, 'name':element, 'id':element}).appendTo(paragraph);
        return paragraph;
      }

      //function for creating submit paragraph
      function getSubmitParagraph(){
        var submitParagraph = $('<p/>');
        $('<input/>', {'type':'submit', 'class':'button','id':'show', 'value':'Show'}).appendTo(submitParagraph);
        $('<input/>', {'type':'submit', 'class':'button','id':'next', 'value':'Next'}).appendTo(submitParagraph);
        $('<input/>', {'type':'submit', 'class':'button','id':'back', 'value':'Back'}).appendTo(submitParagraph);
        $('<input/>', {'type':'submit', 'class':'button','id':'new', 'value':'New'}).appendTo(submitParagraph);
        $('<input/>', {'type':'submit', 'class':'button','id':'edit', 'value':'Edit'}).appendTo(submitParagraph);
        return submitParagraph;
      }


      //AJAX Functions to show, browse, create, update and delete addressbook content
      //index variable to enable browsing through json array of crud.json file
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

      //Creating xmlHttpRequestObject 
      function getAjaxRequest(){
          var request = $.ajax({
              type: "GET",
              url: "data/crud.json",
              datatype: "json"
          });
          return request;
      };

      //removing old content from template
      function clearOldContent(){
        $('#boxcontent').children().remove();
        $('#output').children().remove();
        $('#output').removeClass('output_table');
        $('#output').removeClass('output_contact');
      };

    });

  });
}($));













