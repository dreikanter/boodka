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

  # TODO: Refactor
  def money_cell(value, options = {})
    classes = %w(form-control text-right balance-cell)
    highlight = options[:highlight]
    highlight_negative = [:both, :negative].include?(highlight)
    highlight_positive = [:both, :positive].include?(highlight)
    classes << 'negative' if highlight_negative && (value < 0)
    classes << 'positive' if highlight_positive && (value > 0)
    no_cents = options[:no_cents] || false

    tag :input,
        value: value.format(symbol: false, no_cents: no_cents),
        type: :text,
        class: classes.join(' '),
        readonly: true
  end
end
