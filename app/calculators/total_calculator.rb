class TotalCalculator < BasicCalculator
  def initialize(options = {})
    @account = options.fetch(:account)
    @at = options[:at] || DateTime.now
  end

  def calculate
    last_reconciliation.amount - outflows + inflows
  end

  def base_currency
    ENV['base_currency']
  end

  def last_reconciliation
    @last_reconciliation ||= find_last_reconciliation
  end

  def find_last_reconciliation
    recs = Reconciliation.where(account: @account)
    recs = recs.where('created_at < ?', @at)
    result = recs.order(created_at: :desc).first || zero_rec
    Log.debug "Last reconciliation: #{result.created_at}"
    result
  end

  def zero_rec
    Reconciliation.new(
      account: @account,
      created_at: first_transaction_created_at
    )
  end

  def first_transaction_created_at
    first_transaction.try(:created_at) || DateTime.now
  end

  def first_transaction
    Transaction.where(account: @account).order(created_at: :asc).first
  end

  def time_frame
    next_day_after(last_reconciliation.created_at)..@at
  end

  def transactions
    @transactions ||= find_transactions
  end

  def find_transactions
    Log.debug "Transactions in interval: #{time_frame}"
    Transaction.where(account: @account, created_at: time_frame)
  end

  def outflows
    transactions_sum(Const::OUTFLOW)
  end

  def inflows
    transactions_sum(Const::INFLOW)
  end

  def transactions_sum(direction)
    transactions.where(direction: direction).map(&:calculated_amount).sum
  end

  def next_day_after(date)
    next_day = date + 1.day
    DateTime.new(next_day.year, next_day.month, next_day.day, 0, 0, 0)
  end
end
