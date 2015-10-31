class TotalUncategorizedExpenseCalculator < BasicCalculator
  def initialize(options = {})
    @period = options.fetch(:period)
  end

  def calculate
    base_amount = -> (t) { t.amount.exchange_to(Conf.base_currency) }
    as_money transactions.map(&base_amount).sum
  end

  private

  def transactions
    @period.transactions.where(
      direction: Const::OUTFLOW,
      category_id: nil,
      transaction_id: nil
    )
  end
end
