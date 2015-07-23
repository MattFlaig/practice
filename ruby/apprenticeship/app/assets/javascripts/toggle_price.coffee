register_plugin 'toggle-price', {
  handler: (args) ->
    return if $(@).data('toggle_price_handled')
    $all = $("[data-toggle-price='#{args.opts}']")
    total = $all.length

    $all.data('toggle_price_handled', true)

    $all.on 'click', (e) ->
      e.preventDefault()
      $(@).addClass('hidden')
      next_pos = ($all.index($(@)) + 1) % total
      $next_el = $all.eq(next_pos)
      $next_el.removeClass('hidden')

      $price = $(@).closest('form').find('[name="price_id"]')
      $price.data('unitPrice', $next_el.data('price').value)
      $price.val($next_el.data('price').id)

      $price.trigger 'change'
}
