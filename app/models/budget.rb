# == Schema Information
#
# Table name: budgets
#
#  id              :integer          not null, primary key
#  period_id       :integer          not null
#  category_id     :integer          not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  memo            :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Budget < ActiveRecord::Base
  validates :period_id, :category_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :amount_currency, inclusion: { in: Const::CURRENCY_CODES }

  monetize :amount_cents, with_model_currency: :amount_cents_currency

  belongs_to :period
  belongs_to :category

  delegate :year, :month, to: :period

  after_initialize :set_base_currency

  def actual
    Money.new(expense_amounts.sum, base_currency)
  end

  def balance
    # Money.new(amount, base_currency) - actual + previous_balance
    a = Money.new(amount, base_currency).exchange_to(base_currency)
    b = actual
    c = previous_balance.exchange_to(base_currency)
    Log.info
    Log.info "#{a.amount} #{a.currency}"
    Log.info "#{b.amount} #{b.currency}"
    Log.info "#{c.amount} #{c.currency}"
    a - b + c
  end

  private

  def time_frame
    start = DateTime.new(year, month)
    start..(start + 1.month - 1.second)
  end

  def base_currency
    ENV['base_currency']
  end

  def expense_transactions
    Transaction.outflows.where(category: category, created_at: time_frame)
  end

  def expense_amounts
    expense_transactions.map { |t| t.amount.exchange_to(base_currency) }
  end

  def previous_balance
    prev_period = period.previous_period
    prev_period.persisted? ? prev_period.budget_for(category).balance : Money.new(0, base_currency)
  end

  def zero_amount
    Money.new(0, base_currency)
  end

  def set_base_currency
    amount = Money.new(amount_cents, base_currency)
  end
end
