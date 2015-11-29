class SmartBuilder < ActionView::Helpers::FormBuilder
  def text(field, options = {})
    classes = ['form-control', options[:class]].join(' ')
    group_for(field) { text_field(field, options.merge(class: classes)) }
  end

  def area(field, options = {})
    classes = ['form-control', options[:class]].join(' ')
    group_for(field) { text_area(field, options.merge(class: classes)) }
  end

  def popup_submit_group(options = {})
    group { popup_submit_button(options) }
  end

  def check(field, label, options = {})
    content = check_box(field, {}, 'true', 'false') + " #{label}"
    h.content_tag(:div, class: 'checkbox') { h.content_tag(:label) { content } }
  end

  def account_select(field)
    select(field, options: options_for_account_select(field))
  end

  def currency_select(field)
    select(field, options: options_for_currency_select(field))
  end

  def datetime(field, options = {})
    value = object.send(field).try(:strftime, Const::DATEPICKER_FORMAT_PARSE)
    classes = ['form-control date-time-picker', options[:class]].join(' ')
    content = text_field(field, **options.merge(value: value, class: classes))
    group_for(field) { content }
  end

  def static(field, value = nil)
    value = value || object.send(field)
    group_for(field) { h.content_tag(:p, value, class: 'form-control-static') }
  end

  def amount_input
    content = amount_text_input + directiod_radios
    labeled_group(:amount) { h.content_tag(:div, class: 'row') { content } }
  end

  private

  def group(field = nil)
    h.content_tag(:div, class: group_classes(field).join(' ')) { yield }
  end

  def group_classes(field)
    ['form-group'].tap { |a| a << 'has-error' if (field && errors(field).any?) }
  end

  def labeled_group(field)
    group(field) { label(field, class: 'control-label') + yield }
  end

  def group_for(field)
    labeled_group(field) { yield + field_errors(field) }
  end

  def errors(field)
    @object.errors[field]
  end

  def field_errors(field)
    h.content_tag(:span, errors(field).join(', '), class: 'help-block')
  end

  SUBMIT_OPTIONS = {
    class: 'btn btn-success submit-button',
    data: { disable_with: 'Processing...' }
  }

  def popup_submit_button(options = {})
    submit(options[:caption], **SUBMIT_OPTIONS) + ' ' + popup_cancel_button
  end

  # TODO: Cache Account#default_id

  def account_option(account)
    caption = account.display_title_with_currency,
    data = { 'data-currency' => account.currency }
    [caption, account.id, data]
  end

  def options_for_account_select(field)
    accounts = Account.ordered.decorate.map { |a| account_option(a) }
    h.options_for_select(accounts, @object.send(field))
  end

  def options_for_currency_select(field)
    selected = @object.send(field)
    h.options_for_select(Const::CURRENCY_CODES, selected)
  end

  AMOUNT_TEXT_INPUT_PARAMS = {
    placeholder: 'Amount',
    autofocus: true,
    class: 'form-control select-on-focus input-amount',
    data: { direction: '' }
  }

  def amount_text_input
    h.content_tag(:div, class: 'col-sm-6') do
      text_field(:amount, **AMOUNT_TEXT_INPUT_PARAMS)
    end
  end

  DIRECTION_OPTIONS = {
    inflow: 'Income',
    outflow: 'Expense'
  }

  def direction_radios
    h.content_tag(:div, class: 'col-sm-6') do
      radio_buttons(:direction, options: DIRECTION_OPTIONS)
    end
  end

  RADIO_OPTIONS = {
    class: 'btn-group',
    data: { toggle: 'buttons' }
  }

  def radio_buttons(field, options = {})
    items = radio_items(field, options[:options], object.send(field))
    group { h.content_tag(:div, **RADIO_OPTIONS) { items } }
  end

  def radio_items(field, options, checked_value)
    options.map { |k, v| radio_item(field, k, v, checked_value) }.inject(:+)
  end

  def radio_item(field, value, caption, checked_value)
    content = radio_with_caption(field, value, caption)
    classes = radio_label_classes(value, checked_value)
    label(field, class: classes) { content }
  end

  def radio_label_classes(value, checked_value)
    "btn btn-default#{' active' if (checked_value.to_s == value.to_s)}"
  end

  def radio_with_caption(field, value, caption)
    classes = "radio-#{field} radio-option-#{value}"
    params = { checked: checked, autocomplete: 'off', class: classes }
    [radio_button(field, value, **params), ' ', caption].map(&:html_safe).join
  end

  def select(field, options = {})
    classes = "select select-#{field.to_s.gsub('_', '-')}"
    params = { data: { width: '100%' }, class: classes }
    group_for(field) { super(field, options[:options], {}, **params) }
  end

  def popup_cancel_button
    params = { class: 'btn btn-default', data: { dismiss: 'modal' } }
    h.link_to('Cancel', '#', **params)
  end

  def h
    @template
  end
end
