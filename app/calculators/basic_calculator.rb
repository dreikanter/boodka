class BasicCalculator
  def as_money(value)
    (value == 0) ? zero : value
  end

  def zero
    Money.new(0, Conf.base_currency)
  end
end
