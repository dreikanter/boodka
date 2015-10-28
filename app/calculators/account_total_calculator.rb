class AccountTotalCalculator < BasicCalculator
  def initialize(options = {})
    @account = options.fetch(:account)
  end

  def calculate
    as_money(sum(Const::INFLOW) - sum(Const::OUTFLOW))
  end

  private

  def sum(direction)
    transactions = @account.transactions.where(direction: direction)
    transactions.map(&:calculated_amount).sum
  end
end
