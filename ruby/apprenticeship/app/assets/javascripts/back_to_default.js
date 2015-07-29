var reset_quantity = function($form){
  $form = $form.closest('form');
  $form.find('[name="order_item[quantity]"]').val(1);
};

var reset_size = function($form){
  $form = $form.closest('form');
  $all_sizes = $form.find('.food_description a.label.label-primary');
  $hidden_size = $form.find('.food_description a.label.label-primary.hidden');
  var hidden_price = $hidden_size.data('price').value;
  //var hidden_id = $hidden_size.data('price').id;
  if(hidden_price == 2300){
    $hidden_size.removeClass('hidden');
    $all_sizes.eq(1).addClass('hidden');
    //$hidden_field = $form.find('[name="price_id"]');
    //$hidden_field.val(hidden_id);
  }
};

var reset_extras = function($form){
  $form = $form.closest('form');
  var form_id = $form.data('id');
  $toggle_extras = $('#toggle_extras_' + form_id);
  if($toggle_extras.attr('aria-expanded', 'true')){
    $toggle_extras.collapse('hide');
    uncheck_extra_checkboxes($form);
    set_extra_button_text($form);
  }
};

var uncheck_extra_checkboxes = function($form){
  $form.find('input:checkbox:checked').map(function(){
    $(this).removeAttr('checked');
  });
};

var set_extra_button_text = function($form){
  $text = $form.find('.extras_info');
  if($text.text() != 'ohne Extras'){
    $text.text('ohne Extras');
    $icon = $form.find('[data-show-extras-done]');
    if($icon.hasClass('open')){
      $icon.removeClass('open');
    }
  }
};


$(document).ready(function(){
  $('#order').on('ajax:success', '.new_order_item', function(){
    $form = $(this).closest('form');
    reset_quantity($form);
    reset_size($form);
    reset_extras($form);
    //$form.find('[name="price_id"]').trigger('change');
    $form.find('a[data-toggle-price-done] :visible').trigger('change');
    recalculate_subtotal($form); // from update_price.js
  });
});