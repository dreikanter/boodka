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
  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :amount_currency, inclusion: { in: Const::CURRENCY_CODES }

  monetize :amount_cents, with_model_currency: :amount_currency

  belongs_to :period
  belongs_to :category

  delegate :year, :month, :date, to: :period

  after_initialize :set_base_currency

  def actual
    Money.new(expense_transactions.map { |t| t.calculated_amount_cents }.sum, base_currency)
  end

  def balance
    previous_balance + amount - actual
  end

  def transactions
    Transaction.where(category: category, created_at: time_frame)
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
    transactions.where(direction: Const::OUTFLOW)
  end

  def previous_balance
    period.previous_period.try(:budget_for, category).try(:balance) || zero
  end

  def zero
    Money.new(0, base_currency)
  end

  def set_base_currency
    amount_currency = base_currency
  end
end
