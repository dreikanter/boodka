class BasicCalculator
  def as_money(value, currency = nil)
    (value == 0) ? zero(currency) : value
  end

  def zero(currency = nil)
    Money.new(0, currency || Conf.base_currency)
  end
end
