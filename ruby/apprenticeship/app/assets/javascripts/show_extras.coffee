set_extra_warning = ($toggle_extras, count) ->
  $warning = $toggle_extras.find('.extras_warning')
  count >= 5 && $warning.removeClass('hidden') || $warning.addClass('hidden')

set_extra_cb_toggles = ($toggle_extras, count) ->
  unless $toggle_extras.data('checkboxes')
    $toggle_extras.data('checkboxes', $toggle_extras.find(':checkbox'))

  $cbs = $toggle_extras.data('checkboxes').not(':checked')
  if count >= 5
    $cbs.prop 'disabled', true
    $cbs.closest('label').addClass 'text-muted'
  else
    $cbs.prop 'disabled', false
    $cbs.closest('label').removeClass 'text-muted'

set_extra_link_text = ($link, count) ->
  if count == 0 then $link.text 'ohne Extras'
  else if count == 1 then $link.text 'mit einem Extra'
  else $link.text "mit #{count} Extras"

toggle_extras_request = (id, $toggle_extras, show = true) ->
  $toggle_extras.removeData 'checkboxes'
  $.ajax {
    url: 'pages/toggle_extras'
    method: 'POST'
    data: {
      food_id: id
      price_id: $toggle_extras.closest('form').find('[name="price_id"]').val()
      extras: $toggle_extras.find('input:checkbox:checked').map(->$(@).val()).get()
    }
    success: (data) -> render_toggle_extras(data, $toggle_extras, show)
  }

render_toggle_extras = (data, $toggle_extras, show = true) ->
  $toggle_extras.html data.toggle_extras
  $toggle_extras.collapse('show') if show
  $toggle_extras.find(':checkbox:first').trigger 'change'

  count = $toggle_extras.find(':checked').length
  set_extra_cb_toggles($toggle_extras, count)
  set_extra_warning($toggle_extras, count)

register_plugin 'show-extras', {
  handler: (args) ->
    $link = $(@)
    $toggle_extras = $('#toggle_extras_' + args.opts)

    $(@).on 'click', (e) ->
      e.preventDefault()
      if $toggle_extras.is(':visible')
        $toggle_extras.collapse('hide')
        $link.removeClass 'open'
      else
        toggle_extras_request(args.opts, $toggle_extras)
        $link.addClass 'open'

    $toggle_extras.on 'change', ':input', ->
      count = $toggle_extras.find(':checked').length
      set_extra_link_text($link.find('.text'), count)
      set_extra_warning($toggle_extras, count)
      set_extra_cb_toggles($toggle_extras, count)

    $(@).closest('form').on 'change', '[name="price_id"]', ->
      toggle_extras_request(args.opts, $toggle_extras, false)
}
