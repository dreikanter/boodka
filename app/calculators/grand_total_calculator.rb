class GrandTotalCalculator < BasicCalculator
  def initialize(options = {})
    @at = options[:at] || Time.current
  end

  def calculate
    as_money(Account.all.map { |a| total(a) }.sum, Conf.base_currency)
  end

  private

  def total(account)
    Calc.total(account: account, at: @at).exchange_to(Conf.base_currency)
  end
end
