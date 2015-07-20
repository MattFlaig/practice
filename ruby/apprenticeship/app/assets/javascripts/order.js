var render_modal = function(data){
  if(data.show_order){
    $('#show_order_modal').html(data.show_order);
    $('#show_order_modal').trigger('st:created');
    $('#show_order_modal').modal('show');
  }
  else if(data.show_pickup_order){
    $('#show_order_modal').html(data.show_pickup_order);
    $('#show_order_modal').trigger('st:created');
    $('#show_order_modal').modal('show');
  }
};

var render_toggle_extras = function(data){
  var $toggle_extras = $('#toggle_extras_' + data.food_id);
  if(data.name != 'price_id'){
    if($toggle_extras.html().length > 0 && $toggle_extras.is(':visible')){
      $toggle_extras.collapse('hide');
      $toggle_extras.on('hidden.bs.collapse', function(){
        $toggle_extras.hide();
      });
    }
    else{
      $toggle_extras.html(data.toggle_extras).hide();
      $toggle_extras.show().collapse('show');
    }
  }
  else{
    $toggle_extras.html(data.toggle_extras);
  }

};

var toggle_extras_request = function(id, $element, $toggle_extras){
  $form = $element.closest('form');
  $.ajax({
    url: 'pages/toggle_extras',
    method: 'POST',
    data: {
      food_id: id,
      price_id: $form.find('[name="price_id"] option:selected').val(),
      name: $element.attr('name'),
      extras: $toggle_extras.find('input:checkbox:checked').map(function(){
                return $(this).val();
              }).get()
    },
    success: function(data) {
      render_toggle_extras(data);
    }
  });
};

var extras_count = function($form) {
  $form = $form.closest('form');
  var extras_arr = $form.find('input:checkbox:checked').map(function(){
    return $(this).data('extra-price');
  }).get();
  return extras_arr.length;
};

var disable_unchecked_extras = function($form){
  $form = $form.closest('form');
  $form.find('input:checkbox:not(:checked)').map(function(){
    $(this).attr('disabled', 'disabled');
    $(this).addClass('disabled');
  });
};

var enable_unchecked_extras = function($form){
  $form = $form.closest('form');
  $form.find('input:checkbox:not(:checked)').map(function(){
    $(this).removeAttr('disabled');
    $(this).removeClass('disabled');
  });
};

var set_extras_message = function($form, extras_number){
  $form = $form.closest('form');
  $message = $form.find('.extras_message');
  $message.text('Bitte auswählen (' + extras_number + ' / 5):');
}

var set_extras_warning = function($form, extras_number){
  $form = $form.closest('form');
  $warning = $form.find('.extras_warning');
  if(extras_number >= 5){
    $warning.text('Maximalzahl Extras erreicht!');
  }
  else{
    $warning.text('');
  }
}

$(document).ready(function(){
  $('#order').on('change', 'input[name="extras[extra_ids][]"]', function(){
    var extras_number = extras_count($(this));
    set_extras_message($(this), extras_number);
    if (extras_number >= 5){
      disable_unchecked_extras($(this));
      set_extras_warning($(this), extras_number);
    }
    else{
      enable_unchecked_extras($(this), extras_number);
      set_extras_warning($(this), extras_number);
    }
  });

  $('.stays_active li a').on('click', function(){
    $list = $(this).parents().eq(2);
    $list.find('li').each(function(){
      $(this).removeClass('active');
    });
    $(this).parent().addClass('active');
  });

  $('#order').on('click', '.show_extras', function(){
    var id = $(this).data('id');
    $toggle_extras = $('#toggle_extras_' + id);
    toggle_extras_request(id, $(this), $toggle_extras);
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

  $('#order').on('change', 'select[name="price_id"]', function(){
    var $form = $(this).closest('form');
    var id = $form.attr('data-id');
    $toggle_extras = $('#toggle_extras_' + id);
    if($toggle_extras.length === 0) return;
    if($toggle_extras.html().length > 0 && $toggle_extras.is(':visible')){
      toggle_extras_request(id, $(this), $toggle_extras);
    }
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
