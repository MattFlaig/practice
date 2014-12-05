(function($){
  $(document).ready(function(){

    $('#loadstyling').click(function(event){
      event.preventDefault();
      clearOldContent();
      
      var stylingContent = getStylingContent();
      $('#boxcontent').html(stylingContent);
      var styleNumber = 2;

      if($('#change_css').length > 0){
        $('#change_css').click(function(){

          $('link[rel=stylesheet]:last').attr('href','css/mysite_' + styleNumber + '.css');
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

      function getStylingContent(){
        var button = $('<div/>',{
          'class' : 'big_button',
          'id' : 'change_css',
          'text' : 'Change Styling!'
        });
        return button;
      };

      function clearOldContent(){
        $('#boxcontent').children().remove();
        $('#output').children().remove();
        $('#output').removeClass('output_table');
        $('#output').removeClass('output_contact');
      };
    });
  });
}($));


