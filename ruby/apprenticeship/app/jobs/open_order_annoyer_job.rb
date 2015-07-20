class OpenOrderAnnoyerJob < ActiveJob::Base
  queue_as :default

  def self.repeat_in
    3.minutes
  end

  def perform(order)
    @order = order
    return if @order.status != 'submitted'

    warn

    OpenOrderAnnoyerJob.set(wait: OpenOrderAnnoyerJob.repeat_in).perform_later(@order)
  end

  private

  def warn
    Rails.logger.info "Warning about submitted offer ##{@order.id}"
    XmppHelper.send_message @order.xmpp_reminder
  end
end
