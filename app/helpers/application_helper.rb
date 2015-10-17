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
end
