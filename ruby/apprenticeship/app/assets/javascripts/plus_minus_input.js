$(function() {
  $('[data-plus-minus-input]').on('click', function(e) {
    $input = $(e.delegateTarget).find('input:text');
    var operator = $(e.target).attr('value');

    var adder = 0;
    if(operator == '+'){
      adder = 1;
    } else if(operator == '-') {
      adder = -1;
    }

    if(adder != 0 ) {
      var new_val = parseInt($input.val()) + adder;
      if (new_val <= 0){
        $input.val('1');
      }
      else{
        $input.val(new_val);
        $input.trigger('change');
      }
    }
  });
});
