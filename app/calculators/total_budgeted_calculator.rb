class TotalBudgetedCalculator < BasicCalculator
  def initialize(options = {})
    @period = options.fetch(:period)
  end

  def calculate
    as_money @period.budgets.map(&:amount).sum
  end
end
