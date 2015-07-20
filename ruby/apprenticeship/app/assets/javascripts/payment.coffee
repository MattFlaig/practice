is_valid_form = ($form) ->
  valid = true
  $form.find(':input').each ->
    this_valid = $(@).get(0).checkValidity()
    valid = false unless this_valid
    return if this_valid

    $(@).closest('.form-group').addClass 'has-error'
  unless valid
    $input = $('<input class="hidden" type="submit">')
    $form.append $input
    $input.trigger('click')
    $input.remove()
  valid

register_plugin 'cc-button', {
  handler: (args) ->
    $button = $(@)
    $form = $(@).closest('form')
    $text = $form.find('[data-show-on-cc]')

    show_hide = ($el) ->
      if $el.val() == 'cc'
        $text.show()
        $button.show()
      else
        $text.hide()
        $button.hide()

    $form.on 'change', '[name="order[payment_type]"]', -> show_hide($(@))
    show_hide($('[name="order[payment_type]"]:checked'))

    $(@).on 'click', (e) ->
      e.preventDefault()

      return unless is_valid_form($form)

      l = Ladda.create $button.get(0)
      l.start()

      email_address =
        $form.find('[name="order[delivery_address_attributes][email]"]').val()

      done = false

      stripe = StripeCheckout.configure {
        key: 'pk_test_dRRpAHqlGxBqRhEplQodiSEa'
        image: '/img/documentation/checkout/marketplace.png'
        token: (token) ->
          $hidden = $('<input type="hidden" name="stripeToken">')
          $hidden.val token.id
          $form.append $hidden
          $form.submit()
          done = true
        closed: ->
          setTimeout -> # give strip some time to work ...
            return if done
            l.stop()?
          , 1000
      }

      stripe.open {
        name: 'Pizza alla Grande'
        description: 'Pizza'
        currency: 'eur'
        allowRememberMe: false
        email: email_address
        panelLabel: '{{amount}} bezahlen'
        amount: parseInt($(@).data('amount'))
      }
}

register_plugin 'cash-button', {
  handler: (args) ->
    $button = $(@)
    $form = $(@).closest('form')
    $text = $form.find('[data-show-on-cash]')

    show_hide = ($el) ->
      if $el.val() == 'cash'
        $text.show()
        $button.show()
      else
        $text.hide()
        $button.hide()

    $form.on 'change', '[name="order[payment_type]"]', -> show_hide($(@))
    show_hide($('[name="order[payment_type]"]:checked'))

    $form.on 'submit', ->
      l = Ladda.create $button.get(0)
      l.start()
}

register_plugin 'paypal-button', {
  handler: (args) ->
    $button = $(@)
    $form = $(@).closest('form')
    $text = $form.find('[data-show-on-paypal]')

    show_hide = ($el) ->
      if $el.val() == 'paypal'
        $text.show()
        $button.show()
      else
        $text.hide()
        $button.hide()

    $form.on 'change', '[name="order[payment_type]"]', -> show_hide($(@))
    show_hide($('[name="order[payment_type]"]:checked'))

    $button.on 'click', (e) ->
      e.preventDefault()

      return unless is_valid_form($form)

      l = Ladda.create $button.get(0)
      l.start()

      window.location = $button.data('url')
}
