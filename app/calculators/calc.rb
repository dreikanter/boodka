class Calc
  def self.calculate(calculator_name, options = {})
    klass = "#{calculator_name}_calculator".camelize.constantize
    klass.new(options).calculate
  end

  def self.method_missing(calculator_name, *args)
    "#{calculator_name}_calculator".classify.constantize.new(args).calculate
  end
end
