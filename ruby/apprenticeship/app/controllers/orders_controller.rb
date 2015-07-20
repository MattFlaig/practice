class OrdersController < ApplicationController
  include ControllerWithCart

  helper_method :permitted_attributes

  def show
    order = current_order
    session[:order_id] ||= order.id
    render_response(order: order)
  end

  def update
    order = current_order
    if params[:finish_order]
      finish_order(order) && return
    else
      order.assign_attributes(order_params)
      order.save!(validate: false)
      hour_type = current_hour_type(Time.zone.now.hour)
      delivery_hours = find_delivery_hours(hour_type)
      delivery_values = format_hours(delivery_hours)
      render_response(cart: { order: order,
                            hour_type: hour_type,
                            delivery_values: delivery_values })

    end
  end

  def confirm_paypal
    paypal_attributes = paypal_request(current_order)
    checkout = paypal_attributes[:request].checkout!(
      params[:token],
      params[:PayerID],
      paypal_attributes[:payment_request]
    )

    payment_status = checkout.ack
    payment_successfull = payment_status.starts_with?('Success')

    finish_order(current_order) if payment_successfull
  end

  def pay_with_paypal
    paypal_attributes = paypal_request(current_order)

    response = paypal_attributes[:request].setup(
      paypal_attributes[:payment_request],
      confirm_paypal_url,
      order_url,
      no_shipping: false, # if you want to disable shipping information
      allow_note: false, # if you want to disable notes
      pay_on_paypal: true # if you don't plan on showing your own confirmation step
    )

    redirect_to response.redirect_uri
  end

  # To gen a test invoice at /orders/invoice
  if Rails.env.development?
    def invoice
      FactoryGirl.reload
      @order = FactoryGirl.build(:order, :confirmed)
      @order.id = 123
      render 'order_mailer/invoice', formats: [:pdf]
    end
  end

  private



  # rubocop:disable Metrics/MethodLength
  def permitted_attributes
    [
      :delivery_type,
      :payment_type,
      :invoice_address_same_as_delivery,
      order_items_attributes: [
        :id,
        :quantity,
        :_destroy
      ],
      delivery_address_attributes: [
        :id,
        :first_name,
        :last_name,
        :company,
        :email,
        :mobile,
        :street,
        :postal
      ],
      invoice_address_attributes: [
        :id,
        :first_name,
        :last_name,
        :company,
        :street,
        :postal,
        :city,
        :country
      ]
    ]
  end

  def order_params
    params.require(:order).permit(permitted_attributes)
  end

  def show_order_json(show_order)
    {
      show_order: render_to_string(
        partial: 'show_order_modal',
        locals: { order: show_order },
        formats: [:html]
      )
    }
  end


  def render_response(order: false, cart: false)
    json = {}
    json = show_order_json(order) if order
    json.deep_merge!(cart_json(cart)) if cart
    respond_to do |format|
      format.json do
        render json: json
      end
    end
  end

  def finish_order(order)
    handle_cc_payment(order) if order.payment_type == 'cc'
    order.finish!
    session[:finished_order_id] = order.id;
    redirect_to order_finished_path
  end

  def handle_cc_payment(order)
    stripe_token = params[:stripeToken]
    fail 'No stripe token?' unless stripe_token

    customer = Stripe::Customer.create(
      email: order.invoice_address.email,
      card: stripe_token
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: order.total_price,
      description: 'Order id ' + order.id.to_s,
      currency: 'eur'
    )
  end

  def paypal_request(order)
    req = Paypal::Express::Request.new(
      username: Rails.application.secrets.paypal['username'],
      password: Rails.application.secrets.paypal['password'],
      signature: Rails.application.secrets.paypal['signature']
    )

    payment_request = Paypal::Payment::Request.new(
      currency_code: :EUR,
      description:   'Bestellung bei Pizza alla Grande',
      quantity:      1,
      amount:        order.total_price.to_f / 100.0
    )

    { request: req, payment_request: payment_request }
  end
end
