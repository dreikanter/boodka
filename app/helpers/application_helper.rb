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

  def recent_time(datetime)
    time_tag(datetime, datetime.strftime(Const::TIME_FORMAT).strip)
  end

  def short_date(datetime)
    time_tag(datetime, datetime.strftime(Const::SHORT_DATE_FORMAT).strip)
  end

  def full_date(datetime)
    time_tag(datetime, datetime.strftime(Const::FULL_DATE_FORMAT).strip)
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
      readonly: options[:readonly],
      data: (options[:html].try(:[], :data) || {}).merge(autonumeric: true)
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

  def relative_time(value)
    return recent_time(value) if recent_time?(value)
    ((Time.current.year == value.year) ? short_date(value) : full_date(value))
  end

  def ops_path(operation)
    year = operation.created_at.try(:year) || now.year
    month = operation.created_at.try(:month) || now.month
    operations_path(year, month)
  end

  def current_period_path
    period_path(now.year, now.month)
  end

  def current_operations_path
    operations_path(now.year, now.month)
  end

  private

  def classificator(object, field)
    [object.class.name.underscore, field].join('-').gsub('_', '-')
  end

  NEAR_FRAME = 1.day

  def now
    @now ||= Time.current
  end

  def recent_time?(value)
    (now > value) && (now - value < NEAR_FRAME)
  end
end
