(function($){
  $(document).ready(function(){
    var image = getSvgImage();
    $('#spacer').html(image);

    function getSvgImage(){
      var start_x = 0;
      var start_y = 0;
      var image = "<svg width=100% height='300'>" ;
      for(var i = 0; i<5; i++ ){

        for(var j = 0; j<50; j++){
          image += "<circle cx='" + start_x +"' cy='" + start_y + 
                   "' r='100' style='fill:teal;opacity:0.2' />";
          start_x += 100;
        }
        start_y += 100;
        start_x = 0;
      }
      image += "</svg>";
      return image;
    }

  });
}($));