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
    classes = %w(form-control text-right)
    classes << classificator(object, field)
    classes << options[:html].try(:[], :class)

    attrs = {
      value: object.send(field).to_f,
      type: :text,
      class: classes.select(&:present?).join(' '),
      id: Selector.for(object, field),
      readonly: options[:readonly]
    }

    tag(:input, (options[:html] || {}).merge(attrs))
  end

  def readonly_cell(object, field, options = {})
    cell(object, field, options.merge(readonly: true))
  end

  def currency_label(currency)
    classes = %W(currency currency-#{currency.to_s.downcase})
    content_tag(:span, currency, class: classes)
  end

  private

  def classificator(object, field)
    [object.class.name.underscore, field].join('-').gsub('_', '-')
  end
end
