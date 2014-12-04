(function($){
  $(document).ready(function(){

    $('#show_table').click(function(event){
      event.preventDefault();
      var values = $('#form').serialize();
      var output = "";

      output += "<table>";
      $.each(values.split('&'), function (index, elem) {
        var vals = elem.split('=');
        output += "<tr><td>" + vals[0] +":" + "</td><td>" + vals[1] + "</td></tr>";
      });
      output += "</table>";

      $('#output').addClass("output_table");
      $('#output').html(output);
    })
  });
}($));







