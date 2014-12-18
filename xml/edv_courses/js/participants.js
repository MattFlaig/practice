(function($){
  $(document).ready(function(){
    initialize();

    function initialize(){
      clearOldContent();
      if($('#boxcontent').children().length == 0){
        getParticipantContent();
      }

      $('#participants').click(function(event){
        event.preventDefault();
        clearOldContent();
        getParticipantContent();
      });
    };

    function getParticipantContent(){  
      var request = getAjaxRequest("participants.xml");
      var xsl = getAjaxRequest("participants.xsl")

      request.done(function(){
        var xmlObject = $.parseXML(request.responseText);
        var output = "";
        output += "<div class='output_courses'><table>"+
                  "<tr><th>First Name</th><th>Last Name</th><th>Email</th><th>"+ 
                  "Course</th><th>Reduction</th></tr>";
        $(xmlObject).find('edv_participants').children().each(function(){
          var firstname = $(this).find(':nth-child(1)').text();
          var lastname = $(this).find(':nth-child(2)').text();
          var email = $(this).find(':nth-child(3)').text();
          var course = $(this).find(':nth-child(4)').text();
          var reduction = $(this).find(':nth-child(5)').text();
          output += "<tr><td>" + firstname + "</td><td>" + lastname + 
                    "</td><td>" + email + "</td><td>" + course + 
                    "</td><td>" + reduction + "</td></tr>";
        });
        output += "</table></div>";
        $('#boxcontent').html(output);
      });

      var xslButton = getXslButton();
      $('#output').html(xslButton);

      $('#style_table').click(function(event){
        event.preventDefault();
        xml = getAjaxRequest("participants.xml");
        xml.done(function(){
          var xmlObject = $.parseXML(xml.responseText);
          xsl = getAjaxRequest("participants.xsl");
          xsl.done(function(){
            var xslObject = $.parseXML(xsl.responseText);
            if (document.implementation && document.implementation.createDocument){
              var result = new XSLTProcessor();
              result.importStylesheet(xslObject);
              resultDocument = result.transformToFragment(xmlObject, document);
              clearOldContent();
              $('#boxcontent').append(resultDocument);
              var cssButton = getCssButton();
              $('#output').html(cssButton);
              $('#course_table').click(function(event){
                event.preventDefault();
                initialize();
              });
            }
          });
        });
      });
    };


    function getCssButton(){
        var button = $('<div/>',{
          'class' : 'big_button_css',
          'id' : 'course_table',
          'text' : 'Style with css'
        });
        return button;
    };

    function getXslButton(){
        var button = $('<div/>',{
          'class' : 'big_button_xsl',
          'id' : 'style_table',
          'text' : 'Style with xsl'
        });
        return button;
    };

	  function clearOldContent(){
	    $('#boxcontent').children().remove();
	    $('#output').children().remove();
	    $('#output').removeClass('output_table');
	  };

		function getAjaxRequest(doc){
		  var request = $.ajax({
		      type: "GET",
		      url: "xml/" + doc,
		      datatype: "xml"
		  });
		  return request;
		};

      
    
  });
}($));