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

  def auto_date(datetime)
    now = Time.now
    return "#{time_ago_in_words(datetime)} ago" if (now - datetime.to_time) < 2.day
    current_year = (now.year == datetime.year)
    current_year ? short_date(datetime) : full_date(datetime)
  end

  def short_date(datetime)
    datetime.strftime(Const::SHORT_DATE_FORMAT)
  end

  def full_date(datetime)
    datetime.strftime(Const::FULL_DATE_FORMAT)
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

  def cell(object, field, options = {})
    value = object.send(field)

    classes = %w(form-control text-right budget-cell)
    classes << highlight_class(options[:highlight], value)
    classes << classificator(object, field)

    format_defaults = { no_cents: true, symbol: false }
    format_defaults.merge(options.slice(:no_cents, :symbol))

    tag(:input,
        value: value.format(format_defaults.merge(options.slice(:no_cents, :symbol))),
        type: :text,
        class: classes.select(&:present?).join(' '),
        id: selector(object, field),
        readonly: options[:readonly],
        **(options[:html] || {}))
  end

  def readonly_cell(object, field, options = {})
    cell(object, field, options.merge(readonly: true))
  end

  def currency_label(currency)
    classes = %W(currency currency-#{currency.to_s.downcase})
    content_tag(:span, currency, class: classes)
  end

  private

  def highlight_class(mode, value)
    return 'negative' if (value < 0) && [:both, :negative].include?(mode)
    return 'positive' if (value > 0) && [:both, :positive].include?(mode)
  end

  def format_money(value, options)
    value.format(
      symbol: options[:symbol] || false,
      no_cents: options[:no_cents] || false
    )
  end

  def classificator(object, field)
    [object.class.name.underscore, field].join('-').gsub('_', '-')
  end

  def selector(object, field)
    return unless object.respond_to?(:selector)
    parts = [object.try(:selector), field].select(&:present?)
    parts.join('-').gsub('_', '-').downcase
  end
end
