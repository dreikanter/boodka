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
end
