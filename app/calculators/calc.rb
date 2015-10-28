class Calc
  def self.calculate(calculator_name, options = {})
    klass = "#{calculator_name}_calculator".camelize.constantize
    klass.new(options).calculate
  end
end
