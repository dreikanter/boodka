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
