class FormObject
  include ActiveModel::Model

  def initialize(params = nil)
    permitted_params.each { |name| self.class.send(:attr_accessor, name) }
    process_params(params).each do |name, value|
      instance_variable_set("@#{name}", value)
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
    []
  end
end
