require 'prawn/measurement_extensions'
prawn_document margin: [1.25.in, 2.cm, 1.25.in, 2.cm] do |pdf|
  pdf.font_families.update(
    'DejaVu Sans' => {
      normal: Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans.ttf'),
      bold: Rails.root.join('app', 'assets', 'fonts', 'DejaVuSans-Bold.ttf')
    }
  )
  pdf.font 'DejaVu Sans'

  sizes = {
    small: 7,
    normal: 10,
    big: 14,
    xl: 18
  }

  pdf.font_size sizes[:normal]

  pdf.fill_color '111111'
  pdf.repeat :all do
    pdf.float do
      pdf.transparent 0.05 do
        pdf.fill do
          pdf.rectangle [-2.cm, pdf.bounds.height + 1.25.in], pdf.bounds.width + 4.cm, 1.in
        end
      end

      pdf.bounding_box(
        [0, pdf.bounds.height + 0.75.in], width: pdf.bounds.width, height: 70 - 0.5.in
      ) do
        pdf.text 'Pizza alla grande Berlino', color: 'C13030', size: sizes[:xl], style: :bold
        pdf.fill_color '999999'
        pdf.text_box(
          %(#{l @order.confirmed_at, format: '%d.%m.%y'}),
          at: [0, pdf.bounds.height], align: :right, size: sizes[:small],
          color: '999999'
        )
        pdf.fill_color '111111'
      end

      pdf.transparent 0.1 do
        pdf.fill do
          pdf.rectangle [-2.cm, -0.5.in], pdf.bounds.width + 4.cm, 0.75.in
        end
      end

      pdf.bounding_box [0, -0.65.in], width: pdf.bounds.width, height: 0.5.in do
        pdf.fill_color '999999'
        pdf.text_box(
          'Pizza alla grande Berlino',
          at: [0, pdf.bounds.height - 0.025.in], size: 9, style: :bold
        )
        pdf.table [
          ['Inh. Andre Sadikaj', '030 / 983 28281', 'Steuernummer: 31/502/00565'],
          ['Schönhauser Allee 156', 'andre@pizzaallagrande.de', 'IBAN: DE26100900007328927009'],
          ['10435 Berlin', 'www.pizzaallagrande.de', 'BIC: BEVODEBB']
        ], position: :right do
          cells.borders = []
          cells.padding = [1, sizes[:normal], 1, sizes[:normal]]
          cells.size = sizes[:small]
        end
      end
    end
  end

  pdf.number_pages(
    'Seite <page> von <total>',
    at: [pdf.bounds.right - 50, pdf.bounds.height + 0.6.in], align: :right,
    size: sizes[:small], color: '999999'
  )

  pdf.fill_color '111111'
  pdf.text @order.invoice_address.mailing_address, size: 10

  pdf.move_down sizes[:normal] * 2

  pdf.text 'Rechnung ' + @order.invoice_number.to_s, size: 16, style: :bold

  pdf.pad sizes[:normal] do
    pdf.text <<-EOF.strip_heredoc.gsub("\n", ' ')
    Basierend auf Ihrer Bestellung vom #{l @order.submitted_at, format: '%d.%m.%Y %H:%M'} Uhr
    stellen wir in Rechnung:
    EOF
  end

  order_table = []
  cell_padding = 4
  @order.order_items.each do |order_item|
    row = []

    row.push [
      pdf.make_cell(
        content: "#{order_item.quantity} x #{order_item.name} (#{order_item.size})",
        borders: [:top], border_color: 'eeeeee',
        padding: [cell_padding, cell_padding, 0, cell_padding]
      ),
      pdf.make_cell(
        content: "#{number_to_currency order_item.total_price / 100.0, unit: '€', locale: :de}",
        align: :right,
        borders: [:top], border_color: 'eeeeee',
        padding: [cell_padding, cell_padding, 0, cell_padding]
      )
    ]

    extra_string =
      if order_item.order_item_extras.any?
        "Mit Extras: #{order_item.order_item_extras.map(&:name).join ', '}"
      elsif order_item.category == 'pizza'
        'Ohne Extras'
      else
        ''
      end

    row.push [
      pdf.make_cell(
        content: extra_string,
        size: sizes[:small],
        borders: [],
        padding: [1, cell_padding, cell_padding, cell_padding]
      ),
      pdf.make_cell(
        content: "(inkl. #{order_item.vat / 100.0} % MwSt.)",
        align: :right, size: sizes[:small],
        borders: [],
        padding: [1, cell_padding, cell_padding, cell_padding]
      )
    ]

    order_table.push [
      pdf.make_table(row, width: pdf.bounds.width)
    ]
  end

  row = []
  row.push [
    pdf.make_cell(
      content: 'Warenwert',
      padding: [cell_padding, cell_padding, 0, cell_padding],
      borders: [:top], border_color: '999999'
    ),
    pdf.make_cell(
      content: "#{number_to_currency @order.value_of_goods / 100.0, unit: '€', locale: :de}",
      align: :right,
      padding: [cell_padding, cell_padding, 0, cell_padding],
      borders: [:top], border_color: '999999'
    )
  ]

  vat_string =
    number_to_currency(@order.vat(discount: false, delivery: false) / 100.0, unit: '€', locale: :de)

  row.push [
    pdf.make_cell(
      content: '',
      borders: [], size: sizes[:small],
      padding: [1, cell_padding, cell_padding, cell_padding]
    ),
    pdf.make_cell(
      content: "(inkl. #{vat_string} MwSt.)",
      align: :right, size: sizes[:small],
      borders: [],
      padding: [1, cell_padding, cell_padding, cell_padding]
    )
  ]

  order_table.push [pdf.make_table(row, width: pdf.bounds.width)]

  if @order.delivery_type == 'delivery'
    row = []
    row.push [
      pdf.make_cell(
        content: 'Lieferkosten',
        padding: [cell_padding, cell_padding, 0, cell_padding],
        borders: [:top], border_color: 'eeeeee'
      ),
      pdf.make_cell(
        content: number_to_currency(2, unit: '€', locale: :de),
        align: :right,
        padding: [cell_padding, cell_padding, 0, cell_padding],
        borders: [:top], border_color: 'eeeeee'
      )
    ]

    row.push [
      pdf.make_cell(
        content: '',
        borders: [], size: sizes[:small],
        padding: [1, cell_padding, cell_padding, cell_padding]
      ),
      pdf.make_cell(
        content: '(inkl. 19.00 % MwSt.)',
        align: :right, size: sizes[:small],
        borders: [],
        padding: [1, cell_padding, cell_padding, cell_padding]
      )
    ]

    order_table.push [pdf.make_table(row, width: pdf.bounds.width)]
  end

  if @order.discount
    row = [[
      pdf.make_cell(
        content: "Rabatt (#{@order.discount} %)",
        padding: cell_padding,
        borders: [:top], border_color: 'eeeeee'
      ),
      pdf.make_cell(
        content: "- #{number_to_currency @order.discount_value / 100.0, unit: '€', locale: :de}",
        align: :right,
        padding: cell_padding,
        borders: [:top], border_color: 'eeeeee'
      )
    ]]

    order_table.push [pdf.make_table(row, width: pdf.bounds.width)]
  end

  row = []
  row.push [
    pdf.make_cell(
      content: 'Summe',
      padding: [cell_padding, cell_padding, 0, cell_padding],
      borders: [:top], border_color: 'aaaaaa', font_style: :bold
    ),
    pdf.make_cell(
      content: "#{number_to_currency @order.total_price / 100.0, unit: '€', locale: :de}",
      align: :right,
      padding: [cell_padding, cell_padding, 0, cell_padding],
      borders: [:top], border_color: 'aaaaaa', font_style: :bold
    )
  ]

  vat_string =
    number_to_currency(@order.vat(discount: true) / 100.0, unit: '€', locale: :de)

  row.push [
    pdf.make_cell(
      content: '',
      borders: [], size: sizes[:small],
      padding: [1, cell_padding, cell_padding, cell_padding]
    ),
    pdf.make_cell(
      content: "(inkl. #{vat_string} MwSt.)",
      align: :right, size: sizes[:small],
      borders: [],
      padding: [1, cell_padding, cell_padding, cell_padding]
    )
  ]

  order_table.push [pdf.make_table(row, width: pdf.bounds.width)]

  pdf.table order_table do
    cells.borders = []
  end

  pdf.pad sizes[:normal] do
    pdf.text(
      case @order.delivery_type
      when 'delivery'
        'Die Bestellung wird geliefert.'
      when 'pickup'
        'Die Bestellung wird selbst abgeholt.'
      else
        fail 'What to do with delivery type ' + @order.delivery_type.to_s
      end
    )

    pdf.text(
      case @order.payment_type
      when 'cash'
        'Die Rechnung ist noch nicht bezahlt.'
      when 'paypal'
        'Die Rechnung ist per Paypal bezahlt.'
      when 'cc'
        'Die Rechnung ist per Kreditkarte bezahlt.'
      else
        fail 'What to do with payment type ' + @order.payment_type.to_s
      end
    )
  end

  pdf.pad sizes[:normal] do
    pdf.text 'Ihr Pizza alla grande Berlino Team'
  end
end
