(function($){
  $(document).ready(function(){

    $('#loadstyling').click(function(event){
      event.preventDefault();
      $('#boxcontent').children().remove();
      
      
      var stylingContent = "<button class='changebutton' id='change_css'>Change Styling!</button>";
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
    });
  });
}($));


