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
    tag(:input, cell_options(object, field, options))
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

  private

  NEAR_FRAME = 1.day

  def now
    @now ||= Time.current
  end

  def recent_time?(value)
    (now > value) && (now - value < NEAR_FRAME)
  end

  def cell_options(object, field, options)
    (options[:html] || {}).merge(
      value: object.send(field).to_f,
      type: :text,
      class: cell_classes(object, field, options),
      id: Selector.for(object, field),
      readonly: options[:readonly],
      data: (options[:html].try(:[], :data) || {}).merge(autonumeric: true)
    )
  end

  def cell_classes(object, field, options)
    %w(form-control text-right).tap do |a|
      a << classificator(object, field)
      a << options[:html].try(:[], :class)
    end.select(&:present?).join(' ')
  end

  def classificator(object, field)
    [object.class.name.underscore, field].join('-').gsub('_', '-')
  end
end
