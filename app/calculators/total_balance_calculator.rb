class TotalBalanceCalculator < BasicCalculator
  def initialize(options = {})
    @period = options.fetch(:period)
  end

  def calculate
    as_money @period.budgets.map(&:balance).sum
  end
end
