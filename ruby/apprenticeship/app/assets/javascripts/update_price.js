var calculate_subtotal = function($form) {
  var price =
    $form.find('[name="order_item[price]"]:checked').data('price-value');

  var quantity =
    $form.find('[name="order_item[quantity]"]').val();

  var $subtotal_price =
    $form.find('[data-subtotal-price]');

  $subtotal_price.text(price * quantity / 100 );
}

$(document).ready(function(){
  $('.new_order_item').on( 'change', function(e) {
    calculate_subtotal($(this));
  });
});
