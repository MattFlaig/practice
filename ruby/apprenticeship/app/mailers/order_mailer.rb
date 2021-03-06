class OrderMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    @address = @order.delivery_address
    mail to: @address.email,
         subject: "Bestätigung Ihrer Bestellung ##{@order.order_number}"
  end

  def acceptance_email(order)
    @order = order
    @address = @order.delivery_address

    unless @order.no_invoice_requested == 1
      attachments['invoice.pdf'] = render_to_string('shared/_invoice', formats: [:pdf])
    end

    mail to: @address.email,
         subject: "Rechnung und Lieferzeit für Ihre Bestellung ##{@order.order_number}"
  end
end
