(function($){
  $(document).ready(function(){
    $('#courses').click(function(event){
      event.preventDefault();
      clearOldContent();
      var courseContent = getCourseContent();
      $('#boxcontent').html(courseContent);


      $('#course_table').click(function(event){
        event.preventDefault();
        var request = getAjaxRequest("courses.xml");
        var xsl = getAjaxRequest("courses.xsl")
 
        request.done(function(){
          var xmlObject = $.parseXML(request.responseText);
          var output = "";
          output += "<div class='output_courses'><table>"+
                    "<thead><tr><th>Name</th><th>Price</th><th>Duration</th><th>"+ 
                    "Description</th><th>Teacher</th></tr>";

          $(xmlObject).find('edv_courses').children().each(function(){
            var name = $(this).find(':nth-child(1)').text();
            var price = $(this).find(':nth-child(2)').text();
            var duration = $(this).find(':nth-child(3)').text();
            var description = $(this).find(':nth-child(4)').text();
            var teacher = $(this).find(':nth-child(5)').text();
            output += "<tbody><tr><td>" + name + "</td><td>" + price + 
                      "</td><td>" + duration + "</td><td>" + description + 
                      "</td><td>" + teacher + "</td></tr>";
          });

          output += "</tbody></table></div>";
          $('#boxcontent').html(output);
        });

        var styleButton = getStyleButton();
        $('#output').html(styleButton);

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
                // result = result.transformToDocument(xmlObject);
                resultDocument = result.transformToFragment(xmlObject, document);
                clearOldContent();
                $('#boxcontent').append(resultDocument);
              }
            });


            // var output = "";
            // $(xmlObject).find('edv_courses').children().each(function(){
            //   output += $(this).text();
            // });

            


          // xsl = getAjaxRequest("courses.xsl").responseXML;
          
          // if (document.implementation && document.implementation.createDocument){
          //   var result = new XSLTProcessor();
          //   alert(result);
          //   result.importStylesheet(xsl);
          //   result = result.transformToDocument(xml);
          //   alert(result);
          //   ser = new XMLSerializer();
          //   for (var x = 0; x < result.childNodes.length; x += 1) {
          //       s += ser.serializeToString(result.childNodes[x]);
          //   }
            
          });

          //   $('#boxcontent').append(s);

          // }
        });

      });



	    function getCourseContent(){
	        var button = $('<div/>',{
	          'class' : 'big_button',
	          'id' : 'course_table',
	          'text' : 'Show Courses'
	        });
	        return button;
	    };

      function getStyleButton(){
          var button = $('<div/>',{
            'class' : 'big_button',
            'id' : 'style_table',
            'text' : 'Style with xsl'
          });
          return button;
      }

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
  });
}($));