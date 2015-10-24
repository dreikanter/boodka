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

  before_validation :sanitize

  def date
    DateTime.new(year, month)
  end

  def self.starting_at(year, month)
    find_or_initialize_by(year: year, month: month)
  end

  def budget_for(category)
    budgets.find_or_initialize_by(category: category)
  end

  private

  def check_time_frame
    if start_at >= end_at
      errors.add_to_base('Time frame dates should be sequential')
    end
  end

  def sanitize
    return unless id.nil?
    self.start_at = DateTime.new(year, month)
    self.end_at = start_at + 1.month - 1.second
  end
end
