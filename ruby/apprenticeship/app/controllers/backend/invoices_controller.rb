class Backend::InvoicesController < Backend::BackendController
  def show
    @order = Order.find(params[:id])
    send_data render_to_string('shared/_invoice', formats: [:pdf]),
              filename: "Rechnung_#{@order.invoice_number}_#{@order.order_number}.pdf",
              disposition: 'inline'
  end
end
