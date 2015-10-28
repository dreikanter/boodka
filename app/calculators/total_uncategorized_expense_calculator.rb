class TotalUncategorizedExpenseCalculator
  def initialize(options = {})
    @period = options[:period]
  end

  def calculate
    uncat_expenses.map { |t| t.amount.exchange_to(Conf.base_currency) }.sum
  end

  private

  def uncat_expenses
    @period.transactions.where(kind: Const::EXPENSE, category_id: nil)
  end
end
