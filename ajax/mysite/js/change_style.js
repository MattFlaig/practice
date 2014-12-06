(function($){
  $(document).ready(function(){

    // Event Handler for Styling link in Header
    $('#loadstyling').click(function(event){
      event.preventDefault();//prevent redirect

      // calling function for deleting old template content
      clearOldContent();
      
      // calling functions to create the styling content and fill the template 
      var stylingContent = getStylingContent();
      $('#boxcontent').html(stylingContent);

      //number of stylesheet to chose next, has to be outside of #change_css-eventhandler 
      var styleNumber = 2;

      //if id of styling button which was just created is present, add eventhandler to it
      if($('#change_css').length > 0){
        $('#change_css').click(function(){

          //finding last stylesheet in header and change its href attribute dynamically
          $('link[rel=stylesheet]:last').attr('href','css/mysite_' + styleNumber + '.css');

          //depending on the stylesheet, change main image in spacer
          if(styleNumber == 1){
            var image ="<img src='img/muster.jpg' alt='blue_waves'/> ";
            $('#spacer').html(image);
            styleNumber = 2;
          }
          else{
            var image ="<img src='img/muster_2.jpg' alt='green_shades'/> ";
            $('#spacer').html(image);
            styleNumber = 1;
          }
        });
      }

      //creating the style button with jquery
      function getStylingContent(){
        var button = $('<div/>',{
          'class' : 'big_button',
          'id' : 'change_css',
          'text' : 'Change Styling!'
        });
        return button;
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


