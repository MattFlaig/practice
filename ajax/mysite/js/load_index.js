(function($){
	$(document).ready(function(){

    var indexContent = getIndexContent();

    if($('#boxcontent').children().length == 0){
	    $('#boxcontent').html(indexContent);
    }

  	$('#loadindex').click(function(event){
  		event.preventDefault();
      clearOldContent();
      $('#boxcontent').html(indexContent);
  	});

    function getIndexContent(){
      var first = getArticle('clipboard', 'Form', 'Fill in the form and see your inputs appearing in a table.');
      var second = getArticle('contacts', 'Address Book', 'Perform CRUD actions on your addresses.');
      var third = getArticle('art', 'Styling', "Change the page's styling and enjoy different visuals.");
      return [first, second, third];
    }

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

    function clearOldContent(){
      $('#boxcontent').children().remove();
      $('#output').children().remove();
      $('#output').removeClass('output_table');
      $('#output').removeClass('output_contact');
    }
	});

}($));