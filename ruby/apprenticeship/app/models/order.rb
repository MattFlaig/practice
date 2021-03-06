class Order < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::NumberHelper

  enum status: {
    booking: 0,
    submitted: 1,
    confirmed: 2,
    completed: 3,
    failed: 4,
    cancelled: 5
  }

  enum delivery_type: {
    delivery: 0,
    pickup: 1
  }

  enum payment_type: {
    cash: 0,
    cc: 1,
    paypal: 2
  }

  validates :status, presence: true
  validates :completed_at, presence: true, if: proc { status == 'completed' }

  with_options if: proc { !%w(booking cancelled).include?(status) } do |o|
    o.validates :total, presence: true
    o.validates :order_number, presence: true
  end

  with_options if: proc { !%w(booking submitted cancelled).include?(status) } do |o|
    o.validates :invoice_number, presence: true
    o.validates :delivery_at, presence: true
  end

  has_many :order_items, inverse_of: :order

  has_one :invoice_address
  has_one :delivery_address

  accepts_nested_attributes_for :order_items
  accepts_nested_attributes_for :delivery_address
  accepts_nested_attributes_for :invoice_address

  scope :invoiced, -> { where('orders.invoice_number is not null') }
  scope :not_cancelled, -> { where('orders.status != :c', c: Order.statuses['cancelled']) }
  scope :online_payment, lambda {
    where('orders.payment_type != :cash', cash: Order.payment_types['cash'])
  }

  before_create do
    invoice_address || build_invoice_address
    delivery_address || build_delivery_address

    delivery_address.country ||= 'Deutschland'
    delivery_address.city ||= 'Berlin'
  end

  before_save do
    next unless delivery_type_changed? || new_record?
    assign_vats_to_order_items
  end

  def assign_vats_to_order_items
    order_items.each do |order_item|
      # always takeout for now, because no way of inhouse order
      order_item.vat = order_item.vats.takeout.first.value
    end
  end

  def invoice_address
    super || delivery_address
  end

  def total_price(discount: true)
    total = order_items.each.sum(&:total_price)
    total -= discount_value if discount
    total += 200 if delivery_type == 'delivery'
    total
  end

  def value_of_goods
    order_items.to_a.sum(&:total_price)
  end

  def vat(discount: false, delivery: true)
    vat_list(binding_opts(binding)).values.flatten.sum
  end

  def vat_list(discount: false, delivery: true)
    vats = order_items.each_with_object({}) do |order_item, list|
      add_order_item_vat(order_item, list, discount: discount)
    end

    add_delivery_vat(vats, discount: discount) if delivery_type == 'delivery' && delivery

    vats
  end

  def multiple_vats?
    vat_list.keys.length > 1
  end

  def discount_value
    (total_price(discount: false) * (discount.to_i / 100.0)).round
  end

  before_validation do
    next unless new_record? || delivery_time_changed?
    self.delivery_at =
      if !delivery_time || !confirmed_at
        nil
      else
        t = confirmed_at + delivery_time.minutes
        begin
          t.change(min: (t.min + 4).round(-1))
        rescue ArgumentError
          t.change(min: 0, hour: t.hour + 1)
        end
        t
      end
  end

  def possible_payment_types
    %i(cash).tap do |pt|
      pt.push :cc if Rails.application.secrets.stripe
      pt.push :paypal if Rails.application.secrets.paypal
    end
  end

  def finish!
    if status != 'booking'
      Rails.logger.warn "Not finishing order with status: #{status}"
      return
    end

    invoice_address.try(:mark_for_destruction) if destroy_invoice_address?

    assign_attributes(
      total: total_price,
      status: 'submitted',
      submitted_at: Time.zone.now,
      # for the whole order, not for a single food (maybe change name later)
      order_number: Order.maximum(:order_number).to_i + 1
    )

    save!

    after_finish
  end

  def after_finish
    OrderMailer.confirmation_email(self).deliver_later
    XmppHelper.send_message xmpp_text
    PrinterHelper.send_message print_info
    OpenOrderAnnoyerJob.set(wait: OpenOrderAnnoyerJob.repeat_in).perform_later(self)
  end

  def complete!(arg)
    return unless arg && status != 'completed'
    assign_attributes(
      completed_at: Time.zone.now,
      status: :completed
    )
    save!
  end

  def cancel!(arg)
    return unless arg && status != 'cancelled'
    assign_attributes(
      cancelled_at: Time.zone.now,
      status: :cancelled
    )
    save!
  end

  def confirm!(minutes)
    if status != 'submitted'
      Rails.logger.warn "Not confirming order with status: #{status}"
      return
    end

    assign_attributes(
      confirmed_at: Time.zone.now,
      delivery_time: minutes.to_i,
      status: 'confirmed',
      invoice_number: next_invoice_number
    )

    save!

    after_confirm
  end

  def after_confirm
    OrderMailer.acceptance_email(self).deliver_later
  end

  def print_info
    <<-EOF
Neue Bestellung ##{order_number}

#{customer_info}

#{order_items_info}

Fertigstellung: #{requested_delivery_at ? requested_delivery_at.strftime('%d.%m.%Y %H:%M Uhr') : 'So schnell wie möglich'}
Bezahlung: #{payment_type == 'cash' ? 'Bar' : 'Online'}
Zustellung: #{delivery_type == 'delivery' ? 'Lieferung' : 'Abholung'}
Total: #{(total / 100.0).to_s.gsub(/\.[0-9]$/, '\00')} EURO
EOF
  end

  def customer_info
    <<-EOF
#{delivery_address.mailing_address}
#{delivery_address.email}
#{delivery_address.mobile}
    EOF
  end

  def order_items_info
    xmpp_order_item_array.join("\n")
  end

  def transaction_info
    <<-EOF
Fertig zu: #{requested_delivery_at ? '' : 'So schnell wie möglich'}
Zustellung: #{delivery_type == 'delivery' ? 'Lieferung' : 'Abholung'}
Bezahlung: #{payment_type == 'cash' ? 'Bar' : 'Online'}
Lieferkosten: #{delivery_type == 'delivery' ? '2,00 €' : '0,00 €'}
Rabatt: #{discount} %
Total: #{(total / 100.0).to_s.gsub(/\.[0-9]$/, '\00')} €
    EOF
  end

  def xmpp_body
    <<-EOF
#{xmpp_order_item_array.join("\n")}
EOF
  end

  def xmpp_reminder
    <<-EOF
ACHTUNG: Bestellung ##{order_number} ist noch nicht bearbeitet!
Bestellung vom #{submitted_at.strftime '%d.%m.%Y, %H:%H'} Uhr

#{xmpp_body}

Bestellungen verwalten: #{backend_url}
    EOF
  end

  def xmpp_text
    <<-EOF
Neue Bestellung ##{order_number}
#{submitted_at.strftime '%d.%m.%Y, %H:%H'} Uhr

#{xmpp_body}

Bestellungen verwalten: #{backend_url}
    EOF
  end

  private

  def backend_url
    backend_orders_submitted_url login: :PizzaG8
  end

  def destroy_invoice_address?
    invoice_address_same_as_delivery == 1 && invoice_address.is_a?(InvoiceAddress)
  end

  def add_vat(vat, value, vats, discount: false)
    vats[vat] ||= 0
    vats[vat] += value
    vats[vat] -=
      (value * (self.discount.to_i / 100.0)).round if discount
  end

  def add_order_item_vat(order_item, vats, discount: false)
    add_vat(order_item.vat, order_item.vat_value, vats, discount: discount)
  end

  def add_delivery_vat(vats, discount: false)
    add_vat(1900, (200 * 0.19).round, vats, discount: discount)
  end

  def xmpp_order_item_array
    order_items.each_with_object([]).with_index do |(order_item, ordered), index|
      ordered.push(
        "#{index + 1}: #{order_item.quantity} x #{order_item.order_number} #{order_item.size}"
      )
      ordered.push order_item.name
      ordered.push number_to_currency(order_item.total_price / 100.0, locale: :eu)
      if order_item.extras.any?
        ordered.push 'Extras: ' + order_item.extras.map(&:name).join(', ')
      end
      ordered.push ''
    end
  end

  delegate :next_invoice_number, to: :class
  def self.next_invoice_number
    # invoice numbers: W2015-0001
    last = Order.invoiced.last.try(:invoice_number) || "#{Time.zone.today.year}-0000"
    year = last[1..4].to_i
    if year < Time.zone.today.year
      year = Time.zone.today.year
      number = '0001'
    else
      number = (last[6..-1].to_i + 1).to_s.rjust(4, '0')
    end
    "W#{year}-#{number}"
  end
end
