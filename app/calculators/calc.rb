class Calc
  def self.method_missing(calculator_name, *args)
    "#{calculator_name}_calculator".classify.constantize.new(*args).calculate
  end
end
