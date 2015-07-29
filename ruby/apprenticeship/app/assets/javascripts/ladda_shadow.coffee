register_plugin 'ladda-shadow', {
  tag: '.ladda-button'
  handler: (args) ->
    $button = $(@)
    return if $(@).is('[type="submit"]') ||
    $(@).closest('[data-shadow-input]').length == 0 &&
    $(@).closest('[data-shadow-input-done]').length == 0

    $button.on 'click', -> $button.addClass 'disabled'

    to = null
    l = null
    $button.on 'st:shadow:submitting', ->
      to = setTimeout ->
        l = Ladda.create $button.get(0)
        l.start()
      , 500

    $button.on 'st:shadow:submitted', ->
      clearTimeout to

      if args.opts.renable
        $button.removeClass 'disabled'
        l.stop()
        l.remove()
}
