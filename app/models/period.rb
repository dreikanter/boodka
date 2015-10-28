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

  has_many :budgets, dependent: :destroy

  after_initialize :init_boundaries

  def self.find_or_create!(year, month)
    find_or_create_by(year: year, month: month)
  end

  def transactions
    Transaction.where(created_at: start_at..end_at)
  end

  # def date
  #   DateTime.new(year, month)
  # end

  def self.at(year, month)
    find_or_initialize_by(year: year, month: month)
  end

  def budget_for(category)
    (budgets.where(category: category).first || zero_budget(category)).decorate
  end

  def zero_budget(category)
    Budget.new_zero(self, category)
  end

  # def budget_cents!(cat_id, amount_cents)
  #   save! unless self.persisted?
  #   budget = budget_for(Category.find(cat_id))
  #   budget.update!(amount_cents: amount_cents, amount_currency: base_currency)
  #   budget.decorate
  # end

  # def previous_period
  #   self.class.where('start_at < ?', start_at).order(:start_at).last
  # end

  # def total_budgeted
  #   amounts = budgets.map(&:amount)
  #   amounts.empty? ? zero : amounts.sum
  # end

  # def total_expense
  #   amounts_in_base_currrency(outflows)
  # end

  # def total_uncategorized_expense
  #   -amounts_in_base_currrency(uncategorized_outflows)
  # end

  # def total_income
  #   amounts_in_base_currrency(inflows)
  # end

  # def total_balance
  #   cats_balance = Category.all.map { |c| budget_for(c).balance }.sum
  #   cats_balance + total_income - total_expense
  # end

  # def transactions
  #   Transaction.where(created_at: time_frame)
  # end

  # def outflows
  #   transactions.where(direction: Const::OUTFLOW)
  # end

  # def inflows
  #   transactions.where(direction: Const::INFLOW)
  # end

  # def uncategorized_outflows
  #   outflows.where(category_id: nil)
  # end

  # private

  # def base_currency
  #   ENV['base_currency']
  # end

  # # TODO: Use some cleaner way for this
  # def populate
  #   return if persisted?
  #   today = Date.today
  #   self.year = today.year unless year
  #   self.month = today.month unless month
  #   self.start_at = DateTime.new(year, month)
  #   self.end_at = start_at + 1.month - 1.second
  # end

  # def start_at=(value)
  #   super(value)
  # end

  # def end_at=(value)
  #   super(value)
  # end

  # def time_frame
  #   date..(date + 1.month - 1.second)
  # end

  # def previous_total_balance
  #   previous_period.try(:total_balance) || zero
  # end

  # def zero
  #   Money.new(0, base_currency)
  # end

  # def amounts_in_base_currrency(records)
  #   return Money.new(0, base_currency) if records.empty?
  #   records.map(&:amount).sum.exchange_to(base_currency)
  # end

  def init_boundaries
    return if persisted?
    today = Date.today
    self.year = today.year unless year
    self.month = today.month unless month
    self.start_at = DateTime.new(year, month)
    self.end_at = start_at + 1.month - 1.second
  end
end
