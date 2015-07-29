module PrinterHelper
  def self.config
    Rails.application.secrets[:printer]
  end

  def self.send_message(m)
    m = "----------------------------\n\n#{m}\n\n----------------------------\n\n\n\n\n\n\n"
    `echo "#{m.gsub '€', 'EURO'}" | nc #{config['ip']} #{config['port']}`
  end
end
