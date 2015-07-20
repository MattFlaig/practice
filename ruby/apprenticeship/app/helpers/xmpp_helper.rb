module XmppHelper
  def self.send_message(m)
    Rails.application.config.xmpp_client.actors.first.send_message m
  end
end
