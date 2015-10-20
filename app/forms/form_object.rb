class FormObject
  include ActiveModel::Model

  def initialize(params = nil)
    process_params(params).each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  protected

  def process_params(params)
    params ? params.require(param_name).permit(permitted_params) : {}
  end

  def param_name
    self.class.name.underscore.to_sym
  end

  def permitted_params
    raise NotImplementedError
  end
end
