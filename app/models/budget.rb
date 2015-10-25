# == Schema Information
#
# Table name: budgets
#
#  id               :integer          not null, primary key
#  period_id        :integer          not null
#  category_id      :integer          not null
#  planned_cents    :integer          default(0), not null
#  planned_currency :string           default("USD"), not null
#  memo             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Budget < ActiveRecord::Base
  validates :period_id, :category_id, presence: true
  validates :planned, numericality: { greater_than_or_equal_to: 0 }
  validates :planned_currency, inclusion: { in: Const::CURRENCY_CODES }

  monetize :planned_cents, with_model_currency: :amount_cents_currency

  belongs_to :period
  belongs_to :category

  delegate :year, :month, to: :period

  def actual
    Money.new(expense_amounts.sum).exchange_to(base_currency)
  end

  def balance
    Money.new(planned, base_currency) - actual
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
    expense_transactions.map { |t| t.amount }
  end
end
