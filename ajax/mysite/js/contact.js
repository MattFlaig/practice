(function($){
  $(document).ready(function(){

    // Event Handler for Contact link in Header
    $('#loadcontact').click(function(event){
      event.preventDefault();

      // calling function for deleting old template content
      clearOldContent();
      
      // calling functions to create the contact content and fill the template 
      var contactContent = getContactContent();
      $('#boxcontent').html(contactContent);

      //add event handler and initialize AJAX for external XML content
      $('#contact_info').click(function(event){
        event.preventDefault();
        var request = getAjaxRequest();

        //remove the contact button and add contact data from XML instead
        $('#boxcontent').children().remove();

        request.done(function(){
          var xmlObject = $.parseXML(request.responseText);
          var output = "";
          output += "<div class='output_contact'><h1>Contact Data:</h1><table>";

          $(xmlObject).find('contact').children().each(function(){
            var text = $(this).text();
            output += "<tr><td>" + text+ "</td></tr>";
          });

          output += "</table></div>";
          $('#boxcontent').html(output);
        });
        
      });

      //creating contact button
      function getContactContent(){
        var button = $('<div/>',{
          'class' : 'big_button',
          'id' : 'contact_info',
          'text' : 'Contact Details'
        });
        return button;
      };

      //remove old content from template
      function clearOldContent(){
        $('#boxcontent').children().remove();
        $('#output').children().remove();
        $('#output').removeClass('output_table');
        $('#output').removeClass('output_contact');
      };

      //create AJAX request for external XML
      function getAjaxRequest(){
        var request = $.ajax({
            type: "GET",
            url: "data/contact.xml",
            datatype: "xml"
        });
        return request;
      };


    });
  });
}($));


