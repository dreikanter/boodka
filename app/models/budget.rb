# == Schema Information
#
# Table name: budgets
#
#  id            :integer          not null, primary key
#  period_id     :integer          not null
#  category_id   :integer          not null
#  year          :integer          not null
#  month         :integer          not null
#  start_at      :datetime         not null
#  end_at        :datetime         not null
#  amount_cents  :integer          default(0), not null
#  spent_cents   :integer          default(0), not null
#  balance_cents :integer          default(0), not null
#  currency      :string           not null
#  memo          :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Budget < ActiveRecord::Base
  include DateBasedSelector

  validates :period_id, :category_id, presence: true

  validates :amount_cents,
            :spent_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :balance_cents, numericality: true

  validates :currency, inclusion: { in: Const::CURRENCY_CODES }

  monetize :amount_cents, with_model_currency: :currency
  monetize :spent_cents, with_model_currency: :currency
  monetize :balance_cents, with_model_currency: :currency

  belongs_to :period
  belongs_to :category

  after_initialize :init_boundaries
  after_initialize :init_currency

  scope :history, -> { order(start_at: :asc) }

  def self.refresh!(options = {})
    params = options.slice(:year, :month, :category_id)
    Log.info "Updating budget #{params.values.join('/')}"
    find_or_initialize_by(params).refresh!
  end

  def self.new_zero(period, category)
    new(period: period).tap do |b|
      b.category_id = category.id
      b.currency = Conf.base_currency
      b.balance = b.prev_balance
    end
  end

  def refresh!
    self.period = Period.find_or_create!(year, month)
    self.spent = Money.new(expence_cents_sum, Conf.base_currency)
    self.balance = amount - spent + prev_balance
    save!
    next_existing_budget.try(:refresh!)
  end

  def self.at!(year, month, category_id)
    category = Category.find(category_id)
    period = Period.at!(year, month)
    find_or_create_by(
      period: period,
      category: category,
    )
  end

  def next_budget
    date = start_at + 1.month
    Period.at(date.year, date.month).budget_for(category)
  end

  def next_existing_budget
    cat_history.where('start_at > ?', start_at).first
  end

  def prev_existing_budget
    cat_history.where('start_at < ?', start_at).last
  end

  def selector
    "#{super}-#{category_id}"
  end

  def prev_amount
    prev_existing_budget.try(:amount) || zero
  end

  def prev_balance
    prev_existing_budget.try(:balance) || zero
  end

  def copy_prev!
    update!(amount: prev_amount)
    next_existing_budget.try(:refresh!)
  end

  private

  def time_frame
    start_at..end_at
  end

  def zero
    Money.new(0, Conf.base_currency)
  end

  def init_boundaries
    return if persisted?
    self.year ||= period.year
    self.month ||= period.month
    self.start_at = DateTime.new(year, month)
    self.end_at = start_at + 1.month - 1.second
  end

  def init_currency
    self.currency = Conf.base_currency unless persisted?
  end

  def expense_transactions
    Transaction.expenses.where(category_id: category_id, created_at: time_frame)
  end

  def expence_cents_sum
    exchange = -> (t) { t.amount.exchange_to(Conf.base_currency) }
    expense_transactions.map(&exchange).sum
  end

  def cat_history
    self.class.history.where(category_id: category_id)
  end
end
