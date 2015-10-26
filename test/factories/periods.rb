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
  SAMPLE_DATE = Date.today

  factory :current_period, class: Period do
    initialize_with do
      Period.new(year: SAMPLE_DATE.year, month: SAMPLE_DATE.month)
    end
  end

  factory :previous_period, class: Period do
    initialize_with do
      date = SAMPLE_DATE - 1.month
      Period.new(year: date.year, month: date.month)
    end
  end

  factory :ancient_period, class: Period do
    initialize_with do
      date = SAMPLE_DATE - 100.years
      Period.new(year: date.year, month: date.month)
    end
  end
end
