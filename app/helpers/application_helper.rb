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

  def error?(param)
    @errors.present? && @errors.try(:[], param)
  end

  def money_cell(value, options = {})
    classes = %w(form-control text-right balance-cell)
    highlight_negative = options[:both] || options[:negative]
    highlight_positive = options[:both] || options[:positive]
    classes << 'negative' if highlight_negative && (value < 0)
    classes << 'positive' if highlight_positive && (value > 0)

    tag :input,
        value: value.format(symbol: false),
        type: :text,
        class: classes.join(' '),
        readonly: true
  end
end
