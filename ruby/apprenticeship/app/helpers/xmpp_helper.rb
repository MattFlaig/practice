module XmppHelper
  def self.send_message(m)
    SendXmppJob.perform_later(m)
  end
end
