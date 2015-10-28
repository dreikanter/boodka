class TotalUncategorizedExpenseCalculator < BasicCalculator
  def initialize(options = {})
    @period = options.fetch(:period)
  end

  def calculate
    as_money transactions.map { |t| t.amount.exchange_to(Conf.base_currency) }.sum
  end

  private

  def transactions
    @period.transactions.where(kind: Const::EXPENSE, category_id: nil)
  end
end
