(function($){
	$(document).ready(function(){

    //get indexContent and save it in a variable
    var indexContent = getIndexContent();

    //if template is empty (first visit), fill it with indexContent
    if($('#boxcontent').children().length == 0){
	    $('#boxcontent').html(indexContent);
    }

    //add event listener for home link in header,if triggered, clear old template content
    //and fill in indexContent
  	$('#loadindex').click(function(event){
  		event.preventDefault();//prevent redirect
      clearOldContent();
      $('#boxcontent').html(indexContent);
  	});

    //organizing index content into three articles
    function getIndexContent(){
      var first = getArticle('clipboard', 'Form', 'Fill in the form and see your inputs appearing in a table.');
      var second = getArticle('contacts', 'Address Book', 'Perform CRUD actions on your addresses.');
      var third = getArticle('art', 'Styling', "Change the page's styling and enjoy different visuals.");
      return [first, second, third];
    }

    //get article for index content
    function getArticle(icon, headline, text){
      var article = $('<article/>');
      $('<img/>', {
        'src':'img/' + icon + '-icon.png',
        'alt': icon
      }).appendTo(article);
      $('<h3/>',{
        'text': headline
      }).appendTo(article);
      $('<p/>',{
      'text': text
      }).appendTo(article);

      return article;
    }

    //clear old content from template
    function clearOldContent(){
      $('#boxcontent').children().remove();
      $('#output').children().remove();
      $('#output').removeClass('output_table');
      $('#output').removeClass('output_contact');
    }
	});

}($));