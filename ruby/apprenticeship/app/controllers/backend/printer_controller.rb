class Backend::PrinterController < Backend::BackendController
  def ping
    PrinterHelper.send_message "Ping! #{l Time.zone.now}"
    render nothing: true
  end
end
