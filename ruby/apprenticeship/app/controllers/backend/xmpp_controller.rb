class Backend::XmppController < Backend::BackendController
  def ping
    XmppHelper.send_message "Ping! #{l Time.zone.now}"
    render nothing: true
  end
end
