module ApplicationHelper
  FLASH_TYPES = {
    'alert' => 'alert-danger',
    'notice' => 'alert-success',
    'error' => 'alert-danger'
  }

  def flash_type_to_bs_class(flash_type)
    FLASH_TYPES[flash_type.to_s] || 'alert-info'
  end

  def current_action
    "#{params[:controller]}/#{params[:action]}"
  end

  def short_date(datetime)
    datetime.strftime(Const::SHORT_DATE_FORMAT)
  end

  def field_error(model, field)
    return unless error?(model, field)
    content_tag(:span, model.errors[field].join(', '), class: 'help-block')
  end

  def form_group(model, field, &block)
    classes = "form-group#{ ' has-error' if error?(model, field) }"
    content_tag(:div, class: classes) { yield }
  end

  def error?(model, field)
    model.errors[field].any?
  end

  def money_cell(value, options = {})
    classes = %w(form-control text-right)
    classes << highlight_class(options[:highlight], value)
    tag(
      :input,
      value: format_money(value, options),
      type: :text,
      class: classes.join(' '),
      readonly: true
    )
  end

  def money_value(value, options = {})
    content_tag(
      :span,
      format_money(value, options),
      class: highlight_class(options[:highlight], value)
    )
  end

  def currency_label(currency)
    classes = %W(label label-currency label-#{currency.to_s.downcase})
    content_tag(:span, currency, class: classes)
  end

  private

  def highlight_class(highlight, value)
    return 'negative' if (value < 0) && [:both, :negative].include?(highlight)
    return 'positive' if (value > 0) && [:both, :positive].include?(highlight)
  end

  def format_money(value, options)
    value.format(
      symbol: options[:symbol] || false,
      no_cents: options[:no_cents] || false
    )
  end
end
