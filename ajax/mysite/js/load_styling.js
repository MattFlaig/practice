(function($){
  $(document).ready(function(){
    var stylingContent = "";
    $('#loadstyling').click(function(event){
      event.preventDefault();
      $('#boxcontent').html("");
      stylingContent += "<button class='changebutton' id='change_css'>Change Styling!</button>";
      $('#boxcontent').html(stylingContent);
    })
  });
}($));