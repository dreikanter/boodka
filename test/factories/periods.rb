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

FactoryGirl.define do
  factory :current_period, class: Period do
    initialize_with do
      today = Date.today
      Period.new(year: today.year, month: today.month)
    end
  end

  factory :previous_period, class: Period do
    initialize_with do
      date = Date.today - 1.month
      Period.new(year: date.year, month: date.month)
    end
  end

  factory :ancient_period, class: Period do
    initialize_with do
      date = Date.today - 100.years
      Period.new(year: date.year, month: date.month)
    end
  end
end
