(function($){
	$(document).ready(function(){

    var indexContent = getIndexContent();

    if($('#boxcontent').children().length == 0){
	    $('#boxcontent').html(indexContent);
    }
  	$('#loadindex').click(function(event){
  		event.preventDefault();
  		$('#boxcontent').children().remove();
      $('#boxcontent').html(indexContent);
  	});

    function getIndexContent(){
    	var indexContent = "<article><img src='img/clipboard-icon.png'alt='Clipboard'/><h3>Form</h3>" + 
      "<p>Fill in the form and see your inputs appearing in a table.</p></article>"+
      "<article><img src='img/contacts-icon.png' alt='Contacts'/><h3>Address Book</h3>" +
      "<p>Perform CRUD actions on your addresses.</p></article>"+
      "<article><img src='img/art-icon.png' alt='Styling'/><h3>Styling</h3>" + 
      "<p>Change the page's styling and enjoy different visuals.</p></article><br class='clear'/>";
     
      return indexContent;
    }
	});

}($));