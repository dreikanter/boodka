module ApplicationHelper
  def flash_type_to_bs_class(flas_message_type)
    case flas_message_type.to_s
    when 'alert'
      'alert-danger'
    when 'notice'
      'alert-success'
    when 'error'
      'alert-danger'
    else
      'alert-info'
    end
  end

  def current_action
    "#{params[:controller]}/#{params[:action]}"
  end

  def short_date(datetime)
    datetime.strftime(Const::SHORT_DATE_FORMAT)
  end
end
