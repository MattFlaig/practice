register_plugin 'ladda-shadow', {
  tag: '.ladda-button'
  handler: (args) ->
    $button = $(@)
    return if $(@).is('[type="submit"]')

    $button.on 'click', -> $button.addClass 'disabled'

    to = null
    $button.on 'st:shadow:submitting', ->
      to = setTimeout ->
        l = Ladda.create $button.get(0)
        l.start()
      , 500

    $button.on 'st:shadow:submitted', ->
      clearTimeout to
}
