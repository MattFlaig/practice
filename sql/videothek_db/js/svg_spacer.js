(function($){
  $(document).ready(function(){
    initialize();
    setInterval(function(){ initialize() }, 15000);

    function initialize(){
      var image = getSvgImage();
      $('#spacer').html(image);
    }

    function getSvgImage(){
      var start_x = 0;
      var start_y = 0;
      var image = "<svg  width=100% height='300'>" ;
      for(var i = 0; i<7; i++ ){
        for(var j = 0; j<50; j++){

          var randomRed = Math.floor(Math.random() * (256));
          var randomGreen = Math.floor(Math.random() * (256));
          var randomBlue = Math.floor(Math.random() * (256));

          image += "<rect x='" + start_x +"' y='" + start_y + 
                   "' width='50' height='50' style='stroke-width:1;stroke:rgb(0,0,0);fill:rgb(" + 
                   randomRed+ ","+ randomGreen + "," + randomBlue + ");'>" +"<animate attributeName='opacity'"+
                   "values='0.1;0.9;0.1' dur='15s'repeatCount='indefinite'/>" +"</rect>";
          start_x += 50;
        }
        start_y += 50;
        start_x = 0;
      }
      image += "</svg>";

      return image;
    }

  });
}($));