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

  def pick(*props)
    Hash[property_values(props)]
  end

  def property_values(props)
    props.map { |prop| [prop, pick_property(prop)] }
  end

  def property_filter_name(prop)
    "processed_#{prop}".to_sym
  end

  def pick_property(prop)
    filter = property_filter_name(prop)
    puts(self.class.method_defined?(filter) ? filter : prop)
    send(self.class.method_defined?(filter) ? filter : prop)
  end
end
