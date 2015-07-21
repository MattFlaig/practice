module XmppHelper
  def self.send_message(m)
    config = Rails.application.secrets.xmpp
    Rails.logger.debug "Sending XMPP message #{m}"
    `echo "#{m}" | sendxmpp -t -n -u "#{config['username']}" -p "#{config['password']}" -j #{config['server']} #{config['chef']}`
  rescue StandardError => e
    Rails.logger.error "XMPP Error: #{e.message}"
  end
end
