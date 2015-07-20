register_plugin 'food-morph', {
  tag: 'form.new_order_item'
  handler: (args) ->

    $(@).on 'submit', ->
      $(@).css 'z-index', 999
      $append = $('#cart')
      has_input = $('#delivery_mode').length > 0
      $placeholder = $('<div>')
      $placeholder.css {
        position: 'relative'
        top: if has_input then '-350px' else '-100px'
      }
      $placeholder.height 100
      $append.after $placeholder
      ramjet.transform $(@).get(0), $placeholder.get(0),
        done: ->
          $placeholder.remove()
}
