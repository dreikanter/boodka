class AccountTotalCalculator < BasicCalculator
  def initialize(options = {})
    @account = options.fetch(:account)
  end

  def calculate
    sum(Const::INFLOW) - sum(Const::OUTFLOW)
  end

  private

  def sum(direction)
    transactions = @account.transactions.where(direction: direction)
    as_money(transactions.map(&:calculated_amount).sum, @account.currency)
  end
end
