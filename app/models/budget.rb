# == Schema Information
#
# Table name: budgets
#
#  id         :integer          not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime         not null
#  memo       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Budget < ActiveRecord::Base
  validates :start_at, :end_at, presence: true
  validate :check_time_frame

  has_many :budget_categories

  private

  def check_time_frame
    if start_at >= end_at
      errors.add_to_base('Time frame dates should be sequential')
    end
  end
end
