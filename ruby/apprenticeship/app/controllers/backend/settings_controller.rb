class Backend::SettingsController < Backend::BackendController
  def set
    params.require(:settings).permit!.each { |k, v| Settings.send("#{k}=", v) }
    render json: { ok: true }
  end
end
