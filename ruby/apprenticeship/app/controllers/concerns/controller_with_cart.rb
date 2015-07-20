module ControllerWithCart
  extend ActiveSupport::Concern

  included do
    def cart_json(cart)
      {
        replace_content: {
          '#cart_text' => render_to_string(
            partial: 'order_items/cart_text',
            locals: { order: cart[:order],
                      hour_type: cart[:hour_type],
                      delivery_values: cart[:delivery_values] },
            formats: [:html]
          )
        }
      }
    end
  end
end
