# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime         not null
#  year       :integer          not null
#  month      :integer          not null
#  memo       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Period < ActiveRecord::Base
  validates :start_at, :end_at, presence: true
  validate :check_time_frame

  has_many :budgets, dependent: :destroy

  after_initialize :populate

  def date
    DateTime.new(year, month)
  end

  def self.starting_at(year, month)
    find_or_initialize_by(year: year, month: month)
  end

  def budget_for(category)
    (budgets.where(category: category).first || Budget.new(
      period: self,
      category: category,
      amount_cents: 0,
      amount_currency: base_currency
    )).decorate
  end

  def budget_cents!(cat_id, amount_cents)
    save! unless self.persisted?
    budget = budget_for(Category.find(cat_id))
    budget.update!(amount_cents: amount_cents, amount_currency: base_currency)
    budget.decorate
  end

  def previous_period
    self.class.where('start_at < ?', start_at).order(:start_at).last
  end

  def total_budgeted
    budgets.map(&:amount).sum
  end

  def total_expense
    amounts_in_base_currrency outflows
  end

  def total_uncategorized_expense
    amounts_in_base_currrency uncategorized_outflows
  end

  def amounts_in_base_currrency(records)
    return Money.new(0, base_currency) if records.empty?
    records.map(&:amount).sum.exchange_to(base_currency)
  end

  def total_income
    amounts_in_base_currrency inflows
  end

  def total_balance
    budgets.map(&:balance).sum - total_uncategorized_expense
  end

  def transaction
    Transaction.where(created_at: time_frame)
  end

  def outflows
    transaction.where(direction: Const::OUTFLOW)
  end

  def inflows
    transaction.where(direction: Const::INFLOW)
  end

  def uncategorized_outflows
    outflows.where(category_id: nil)
  end

  private

  def check_time_frame
    if start_at >= end_at
      errors.add_to_base('Time frame dates should be sequential')
    end
  end

  def base_currency
    ENV['base_currency']
  end

  # TODO: Use some cleaner way for this
  def populate
    return if persisted?
    today = Date.today
    self.year = today.year unless year
    self.month = today.month unless month
    self.start_at = DateTime.new(year, month)
    self.end_at = start_at + 1.month - 1.second
  end

  def start_at=(value)
    super(value)
  end

  def end_at=(value)
    super(value)
  end

  def time_frame
    date..(date + Const::PERIODS_PER_PAGE.month - 1.second)
  end
end
