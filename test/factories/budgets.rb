# == Schema Information
#
# Table name: budgets
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
  factory :budget do
    start_at "2015-10-21 15:17:05"
end_at "2015-10-21 15:17:05"
memo "MyString"
  end

end
