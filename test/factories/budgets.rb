# == Schema Information
#
# Table name: budgets
#
#  id            :integer          not null, primary key
#  period_id     :integer          not null
#  category_id   :integer          not null
#  year          :integer          not null
#  month         :integer          not null
#  start_at      :datetime         not null
#  end_at        :datetime         not null
#  amount_cents  :integer          default(0), not null
#  spent_cents   :integer          default(0), not null
#  balance_cents :integer          default(0), not null
#  currency      :string           not null
#  memo          :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :budget do
    period_id { FactoryGirl.create(:current_period).id }
    category_id { FactoryGirl.create(:valid_category).id }
    amount_cents 10000
    amount_currency ENV['base_currency']
    memo 'Sample budget'
  end

  factory :previous_budget, parent: :budget do
    period_id { FactoryGirl.create(:previous_period).id }
  end

  factory :ancient_budget, parent: :budget do
    period_id { FactoryGirl.create(:ancient_period).id }
  end
end
