(function($){
  $(document).ready(function(){
    // var counter = 0;
    initialize();
    setInterval(function(){ initialize() }, 15000);

    function initialize(){
      var image = getSvgImage();
      $('#spacer').html(image);
    }

    function getSvgImage(){
      // var colours = ['teal','midnightblue','brown','darkgreen','navy','black','indigo', 'saddlebrown'];
      var start_x = 0;
      var start_y = 0;
      var image = "<svg  width=100% height='300'>" ;
      for(var i = 0; i<5; i++ ){
        for(var j = 0; j<50; j++){
          var randomRed = Math.floor(Math.random() * (256));
          var randomGreen = Math.floor(Math.random() * (256));
          var randomBlue = Math.floor(Math.random() * (256));
          image += "<circle cx='" + start_x +"' cy='" + start_y + 
                   "' r='100' style='fill:rgb(" + 
                   randomRed+ ","+ randomGreen + "," + randomBlue + ");'>" +"<animate attributeName='opacity'"+
                   "values='0.1;0.6;0.1' dur='15s'repeatCount='indefinite'/>" +"</circle>";
          start_x += 100;
        }
        start_y += 100;
        start_x = 0;
      }
      image += "</svg>";

      // if (counter == colours.length - 1){counter = 0;}
      // else{counter += 1;}
      
      return image;
    }

  });
}($));