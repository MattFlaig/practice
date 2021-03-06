(function($){
  $(document).ready(function(){
    initialize();

    function initialize(){
      clearOldContent();
      if($('#boxcontent').children().length == 0){
        getCourseContent();
      }

      $('#courses').click(function(event){
        event.preventDefault();
        clearOldContent();
        getCourseContent();
      });
    };

    function getCourseContent(){  
      var request = getAjaxRequest("courses.xml");
      var xsl = getAjaxRequest("courses.xsl")

      request.done(function(){
        var xmlObject = $.parseXML(request.responseText);
        var output = "";
        output += "<div class='output_courses'><table>"+
                  "<tr><th>Name</th><th>Price</th><th>Duration</th><th>"+ 
                  "Description</th><th>Teacher</th></tr>";
        $(xmlObject).find('edv_courses').children().each(function(){
          var name = $(this).find(':nth-child(1)').text();
          var price = $(this).find(':nth-child(2)').text();
          var duration = $(this).find(':nth-child(3)').text();
          var description = $(this).find(':nth-child(4)').text();
          var teacher = $(this).find(':nth-child(5)').text();
          output += "<tr><td>" + name + "</td><td>" + price + 
                    "</td><td>" + duration + "</td><td>" + description + 
                    "</td><td>" + teacher + "</td></tr>";
        });
        output += "</table></div>";
        $('#boxcontent').html(output);
      });

      var xslButton = getXslButton();
      $('#output').html(xslButton);

      $('#style_table').click(function(event){
        event.preventDefault();
        xml = getAjaxRequest("courses.xml");
        xml.done(function(){
          var xmlObject = $.parseXML(xml.responseText);
          xsl = getAjaxRequest("courses.xsl");
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