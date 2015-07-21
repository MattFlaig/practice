var success_feedback = function(){
  alert('Das Senden Ihrer Nachricht war erfolgreich!');
}

var clear_inputs = function(){
  $inputs = $('#contact').find('.form-control');
  $($inputs).each(function(){
    $(this).val('');
  });
}

$(document).ready(function(){
  $('#contact').on('ajax:success', function(){
    success_feedback();
    clear_inputs();
  });
});
