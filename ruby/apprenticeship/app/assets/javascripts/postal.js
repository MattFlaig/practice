var render_postal = function(data){
  if(data.show_postal){
    $('#show_postal_modal').html(data.show_postal);
    $('#show_postal_modal').trigger('st:created');
    $('#show_postal_modal').modal('show');
  }
  else if(data.show_opening){
    $('#show_postal_modal').html(data.show_opening);
    $('#show_postal_modal').modal('show');
  }
};

var current_hour = function(){
  var now = new Date();
  return now.getHours();
}

var show_postal_request = function(){
  $('.show_postal').on('click', function(){
    $.ajax({
      url: '/pages/show_postal',
      method: 'POST',
      data: {
        orders_open: $(this).orders_open
      },
      success: function(data) {
        render_postal(data);
        set_elements();
        if (data.orders_open === false){
          disable_if_closed();
        }
      }
    });
  });
}

var set_elements = function(){
  $('#show_postal_modal').on('click', '#pickup_button', function(){
    set_pickup_button();
    unset_delivery_button();
    disable_postal();
    disable_delivery_time();
    enable_pickup_time();
    enable_postal_button();
    var button_id = $(this).attr('id');
    set_hidden_field(button_id);
    set_to_grey('.grey_if_pickup');
    unset_grey('.grey_if_delivery');
  });
  $('#show_postal_modal').on('click', '#delivery_button', function(){
    set_delivery_button();
    unset_pickup_button();
    enable_postal();
    enable_delivery_time();
    disable_pickup_time();
    disable_postal_button();
    var button_id = $(this).attr('id');
    set_hidden_field(button_id);
    set_to_grey('.grey_if_delivery');
    unset_grey('.grey_if_pickup');
  });
}

var disable_if_closed = function(){
  disable_delivery_button();
  disable_pickup_button();
  disable_postal();
  disable_pickup_time();
  disable_delivery_time();
  set_to_grey('.grey_if_no_order');
  $('#orders_closed').show();
}

var disable_delivery_button = function(){
  $delivery_button = $('#show_postal_modal').find('#delivery_button');
  $delivery_button.addClass('disabled');
  $delivery_button.attr('disabled', 'disabled');
}

var disable_pickup_button = function(){
  $pickup_button = $('#show_postal_modal').find('#pickup_button');
  $pickup_button.addClass('disabled');
  $pickup_button.attr('disabled', 'disabled');
}

var set_pickup_button = function(){
  $pickup_button = $('#show_postal_modal').find('#pickup_button');
  $pickup_button.removeClass('btn-default');
  $pickup_button.addClass('btn-danger');
}

var unset_pickup_button = function(){
  $pickup_button = $('#show_postal_modal').find('#pickup_button');
  $pickup_button.removeClass('btn-danger');
  $pickup_button.addClass('btn-default');
}

var set_delivery_button = function(){
  $delivery_button = $('#show_postal_modal').find('#delivery_button');
  $delivery_button.removeClass('btn-default');
  $delivery_button.addClass('btn-danger');
}

var unset_delivery_button = function(){
  $delivery_button = $('#show_postal_modal').find('#delivery_button');
  $delivery_button.removeClass('btn-danger');
  $delivery_button.addClass('btn-default');
}

var enable_postal = function(){
  $postal_select = $('select[id="order_delivery_address_attributes_postal"]');
  $postal_select.removeClass('disabled');
  $postal_select.removeAttr('disabled');
}

var disable_postal = function(){
  $postal_select = $('select[id="order_delivery_address_attributes_postal"]');
  $postal_select.addClass('disabled');
  $postal_select.attr('disabled', 'disabled');
}

var enable_pickup_time = function(){
  $pickup_select = $('#requested_pickup').find('select[id="order_requested_delivery_at"]');
  $pickup_select.removeClass('disabled');
  $pickup_select.removeAttr('disabled');
}

var disable_pickup_time = function(){
  $pickup_select = $('#requested_pickup').find('select[id="order_requested_delivery_at"]');
  $pickup_select.addClass('disabled');
  $pickup_select.attr('disabled', 'disabled');
}

var enable_delivery_time = function(){
  $delivery_select = $('#requested_delivery').find('select[id="order_requested_delivery_at"]');
  $delivery_select.removeClass('disabled');
  $delivery_select.removeAttr('disabled');
}

var disable_delivery_time = function(){
  $delivery_select = $('#requested_delivery').find('select[id="order_requested_delivery_at"]');
  $delivery_select.addClass('disabled');
  $delivery_select.attr('disabled', 'disabled');
}



var set_to_grey = function(classname){
  $to_grey = $('#show_postal_modal').find(classname);
  $to_grey.addClass('set_to_grey');
}

var unset_grey = function(classname){
  $unset_grey = $('#show_postal_modal').find(classname);
  $unset_grey.removeClass('set_to_grey');
}

var enable_postal_button = function(){
  button = $('#show_postal_modal').find('.postal_button');
  button.removeClass('disabled');
  button.removeAttr('disabled');
}

var disable_postal_button = function(){
  button = $('#show_postal_modal').find('.postal_button');
  button.addClass('disabled');
  button.attr('disabled', 'disabled');
}

var set_hidden_field = function(button_id){
  var $hidden_field = $('#show_postal_modal').find('input[name="order[delivery_type]"]');
  var $button = $('#show_postal_modal').find('#'+ button_id);
  var delivery_value = $button.data('value');
  $hidden_field.val(delivery_value);
  $hidden_field.trigger('change');
}

var disable_delivery_radio = function(hour){
  if(hour > 11 && hour < 15){
    var $delivery_radio = $('#order').find('.radio #order_delivery_type_delivery');
    var $pickup_radio = $('#order').find('.radio #order_delivery_type_pickup');
    $delivery_radio.addClass('disabled');
    $delivery_radio.attr('disabled','disabled');
    $pickup_radio.attr('checked', 'checked');
  }
}


$(document).ready(function(){
  show_postal_request();


  $('#show_postal_modal').on('change','select[id="order_delivery_address_attributes_postal"]', function(){
    var $check = $('#show_postal_modal').find('.fa-check');
    if($(this).val() != ''){
      enable_postal_button();
    }
    else{
      disable_postal_button();
    }
  });

  //$('#show_postal_modal').on('click', '.postal_button', function(){
  //  enable_delivery_time();
  //  enable_pickup_time();
  //});

  $('#order').ready(function(){
    var hour = current_hour();
    disable_delivery_radio(hour);
  });

});


