var find_unit_price = function($form) {
  $form = $form.closest('form');
  $price_input = $form.find('[name="price_id"]');
  if($price_input.is('select')) {
    return parseInt($price_input.find('option:selected').data('unit-price'));
  } else {
    return parseInt($price_input.data('unit-price'));
  }
};

var find_quantity = function($form){
  $form = $form.closest('form');
  return parseInt($form.find('[name="order_item[quantity]"]').val());
};

var find_extras = function($form) {
  $form = $form.closest('form');
  return $form.find('input:checkbox:checked').map(function(){
    return $(this).data('extra-price');
  }).get();
};

var find_display_price = function($form) {
  $form = $form.closest('form');
  return $form.find('.display_price');
}

var format_currency = function(cents) {
  return (cents / 100).toFixed(2) + ' €';
};

var calculate_extras_total = function($form) {
  $form = $form.closest('form');
  var price = 0;
  var extras = find_extras($form);
  for (var index in extras) {
    price += parseInt(extras[index]);
  }
  return price;
};

var recalculate_subtotal = function($form) {
  $form = $form.closest('form');
  var unit_price = find_unit_price($form);
  var quantity = find_quantity($form);
  var extras_price = calculate_extras_total($form);
  find_display_price($form).text(format_currency(quantity * (unit_price + extras_price)));
};

$(function() {
  $('#order').on('change', '[name="order_item[quantity]"], [name="price_id"], [name="extras[extra_ids][]"]' , function(e) {
    recalculate_subtotal($(this));
  });
});
