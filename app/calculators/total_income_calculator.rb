class TotalIncomeCalculator
  def initialize(options = {})
    @period = options.fetch(:period)
  end

  def calculate
    result = transactions.map { |t| t.exchange_to(Conf.base_currency) }.sum
    (result == 0) ? Money.new(0, Conf.base_currency) : result
  end

  private

  def transactions
    @period.transactions.where(kind: Const::INCOME)
  end
end
