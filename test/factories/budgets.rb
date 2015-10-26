# == Schema Information
#
# Table name: budgets
#
#  id              :integer          not null, primary key
#  period_id       :integer          not null
#  category_id     :integer          not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  memo            :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :budget do
    period_id { FactoryGirl.create(:current_period).id }
    category_id { FactoryGirl.create(:valid_category).id }
    amount_cents 10000
    amount_currency ENV['base_currency']
    memo 'Sample budget'
  end
end
