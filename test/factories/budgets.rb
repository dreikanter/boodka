# == Schema Information
#
# Table name: budgets
#
#  id               :integer          not null, primary key
#  period_id        :integer          not null
#  category_id      :integer          not null
#  planned_cents    :integer          default(0), not null
#  planned_currency :string           default("USD"), not null
#  memo             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :budget do
    
  end

end
