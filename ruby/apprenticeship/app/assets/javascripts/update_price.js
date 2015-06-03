var find_unit_price = function($form){
  var price =
    $form.find('[name="price_id"]:checked').data('price-value');
  if (price === undefined){
    var unsized_price = $form.find('[data-subtotal]').text();
    return unsized_price * 100;
  } else {
    return price;
  }
};

var find_quantity = function($form){
  return $form.find('[name="order_item[quantity]"]').val();
};


var calculate_subtotal = function($form, price, quantity){
  var $subtotal_price = $form.find('[data-subtotal]');

  $subtotal_price.text(price * quantity / 100 + " €");
};

var render_cart_text = function(e, data){
  $('#cart_items_count').text('(' + data.order_items_count + ')');
  $('#cart_text').html(data.cart);
};


$(document).ready(function(){
  $('.new_order_item').on( 'change', function(e) {
    var price = find_unit_price($(this));
    var quantity = find_quantity($(this));
    calculate_subtotal($(this), price, quantity);
  });

  $('.new_order_item').on( 'ajax:success', function(e, data) {
    render_cart_text(e, data);

  });

  $('#cart_text').on( 'ajax:success', '.delete_item', function(e, data) {
    render_cart_text(e, data);
  });

  $('#cart_text').on('change', '.cart_quantity', function() {
    $.ajax({url: 'order_items/' + this.id,
      method: 'PUT',
      data: 'quantity=' + this.value +'&id=' + this.id, 
      dataType: 'script'
    })
  });
});

