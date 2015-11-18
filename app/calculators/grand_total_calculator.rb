class GrandTotalCalculator < BasicCalculator
  def initialize(options = {})
    @at = options[:at] || Time.current
    @currency = options[:currency] || Conf.base_currency
  end

  def calculate
    as_money(Account.all.map { |a| total(a) }.sum, @currency)
  end

  private

  def total(account)
    Calc.total(account: account, at: @at).exchange_to(@currency)
  end
end
