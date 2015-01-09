(function($){
  $(document).ready(function(){
    var counter = 0;
    initialize();
    setInterval(function(){ initialize() }, 15000);

    function initialize(){
      var image = getSvgImage();
      $('#spacer').html(image);
    }

    function getSvgImage(){
      var colours = ['red', 'blue', 'violet', 'yellow', 'green', 'maroon', 'teal', 'midnightblue', 'lime','brown','darkgreen','navy','black','indigo', 'saddlebrown'];
      var start_x = 0;
      var start_y = 0;
      var image = "<svg  width=100% height='300'>" ;
      for(var i = 0; i<7; i++ ){
        for(var j = 0; j<50; j++){
          image += "<rect x='" + start_x +"' y='" + start_y + 
                   "' width='50' height='50' style='stroke-width:1;stroke:rgb(0,0,0);fill:" + colours[counter]+ ";'>" +"<animate attributeName='opacity'"+
                   "values='0.1;0.9;0.1' dur='15s'repeatCount='indefinite'/>" +"</rect>";
          start_x += 50;
          if (counter == colours.length - 1){counter = 0;}
          else{counter += 1;}
        }
        start_y += 50;
        start_x = 0;
      }
      image += "</svg>";

      if (counter == colours.length - 1){counter = 0;}
      else{counter += 1;}
      
      return image;
    }

  });
}($));