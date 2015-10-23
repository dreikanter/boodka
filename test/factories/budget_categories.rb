# == Schema Information
#
# Table name: budget_categories
#
#  id               :integer          not null, primary key
#  budget_id        :integer          not null
#  category_id      :integer          not null
#  planned_cents    :integer          default(0), not null
#  planned_currency :string           default("USD"), not null
#  memo             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :budget_category do
    budget_id 1
category_id 1
planned ""
memo "MyString"
order 1
  end

end
