var render_modal = function(data){
  if(data.show_order){
    $('#show_order_modal').html(data.show_order);
    $('#show_order_modal').trigger('st:created');
    $('#show_order_modal').modal('show');
  }
};

$(document).ready(function(){
  $('.stays_active li a').on('click', function(){
    $list = $(this).parents().eq(2);
    $list.find('li').each(function(){
      $(this).removeClass('active');
    });
    $(this).parent().addClass('active');
  });

  var $toggle_invoice = null;
  $('#order').on(
    'change', '[name="order[invoice_address_same_as_delivery]"]', function() {
      $toggle = $('#toggle_invoice_address');

      if(!$toggle_invoice || $toggle_invoice.length == 0) {
        $toggle_invoice = $('#order #invoice_address');
      }
      if($(this).val() == '0') {
        $toggle.after($toggle_invoice);
      } else {
        $toggle_invoice.detach();
      }
  });

  $(document).on('shown.bs.modal', function() {
    $toggle_invoice = null;
    $('[name="order[invoice_address_same_as_delivery]"]:checked').trigger('change');
  });

  $('#order').on('click', '#order_button button', function(e) {
    e.preventDefault();
    if( $(this).is('[disabled]') ) return;
    $.ajax({
      url: 'orders/show',
      method: 'GET',
      success: function(data) {
        render_modal(data);
      }
    });
  });
});
