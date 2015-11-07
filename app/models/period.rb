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
  include DateBasedSelector

  validates :start_at, :end_at, presence: true

  has_many :budgets, dependent: :destroy

  after_initialize :init_boundaries

  def self.find_or_create!(year, month)
    find_or_create_by(year: year, month: month)
  end

  def transactions
    Transaction.where(created_at: time_frame)
  end

  def self.at(year, month)
    find_or_initialize_by(year: year, month: month)
  end

  def self.at!(year, month)
    find_or_create_by(year: year, month: month)
  end

  def safe_budgets
    return budgets unless new_record?
    Category.all.map { |c| zero_budget(c) }
  end

  # TODO: Momoize this
  def budget_for(category)
    # TODO: Drop decorate
    (budgets.where(category: category).first || zero_budget(category)).decorate
  end

  def zero_budget(category)
    Budget.new_zero(self, category)
  end

  def time_frame
    start_at..end_at
  end

  # Calculated properties

  def total_uncategorized_expense
    Calc.total_uncategorized_expense(period: self)
  end

  def total_income
    Calc.total_income(period: self)
  end

  def total_budgeted
    Calc.total_budgeted(period: self)
  end

  def total_expense
    Calc.total_expense(period: self)
  end

  def total_balance
    Calc.total_balance(period: self)
  end

  def available_to_budget
    Calc.available_to_budget(period: self)
  end

  private

  def init_boundaries
    return if persisted?
    now = Time.current
    self.year = now.year unless year
    self.month = now.month unless month
    self.start_at = DateTime.new(year, month)
    self.end_at = start_at + 1.month - 1.second
  end
end
