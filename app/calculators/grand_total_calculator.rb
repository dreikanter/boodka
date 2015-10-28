class GrandTotalCalculator < BasicCalculator
  def initialize(options = {})
    @at = options.fetch(:at, DateTime.now)
  end

  def calculate
    sum(Const::INFLOW) - sum(Const::OUTFLOW)
  end

  def framed_transactions
    Transaction.where('created_at < ?', @at)
  end

  def sum(direction)
    transactions = framed_transactions.where(direction: direction)
    exchanged = -> (a) { a.calculated_amount.exchange_to(Conf.base_currency) }
    as_money(transactions.map(&exchanged).sum, Conf.base_currency)
  end
end
