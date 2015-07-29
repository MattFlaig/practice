class SendXmppJob < ActiveJob::Base
  queue_as :default

  def perform(m)
    config = Rails.application.secrets.xmpp
    Rails.logger.debug "Sending XMPP message #{m}"
    `echo "#{m}" | sendxmpp -t -n -u "#{config['username']}" -p "#{config['password']}" -j #{config['server']} #{config['chef']}`
    return unless Rails.env.production?
    `echo "#{m}" | sendxmpp -t -n -u "#{config['username']}" -p "#{config['password']}" -j #{config['server']} #{config['admin']}`
  rescue StandardError => e
    Rails.logger.error "XMPP Error: #{e.message}"
  end
end
