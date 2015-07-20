class Address < ActiveRecord::Base
  validates :type, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: /[^@\s\.]+\@[^@\s\.]+\.[^@\s\.]+/ }, allow_nil: true
  validates :street, presence: true
  validates :postal, presence: true
  validates :city, presence: true
  validates :country, presence: true

  belongs_to :order

  def self.types
    %w(invoice_address delivery_address)
  end

  def mailing_address
    <<-EOF.strip_heredoc.gsub(/\n\n+/, "\n").strip
    #{first_name} #{last_name}
    #{company}
    #{street}
    #{postal} #{city}
    #{country}
    EOF
  end
end
