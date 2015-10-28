class AvailableToBudgetCalculator < BasicCalculator
  def initialize(options = {})
    @period = options.fetch(:period)
  end

  def calculate
    grand_total - total_balance
  end

  private

  def grand_total
    as_money Calc.grand_total(at: @period.end_at)
  end

  def total_balance
    as_money Calc.total_balance(period: @period)
  end
end
