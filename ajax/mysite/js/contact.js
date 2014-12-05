(function($){
  $(document).ready(function(){

    $('#loadcontact').click(function(event){
      event.preventDefault();
      clearOldContent();
      
      var contactContent = getContactContent();
      $('#boxcontent').html(contactContent);

      $('#contact_info').click(function(event){
        event.preventDefault();
        var request = getAjaxRequest();
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


      function getContactContent(){
        var button = $('<div/>',{
          'class' : 'big_button',
          'id' : 'contact_info',
          'text' : 'Contact Details'
        });
        return button;
      };

      function clearOldContent(){
        $('#boxcontent').children().remove();
        $('#output').children().remove();
        $('#output').removeClass('output_table');
        $('#output').removeClass('output_contact');
      };

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


