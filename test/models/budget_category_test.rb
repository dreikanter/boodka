# == Schema Information
#
# Table name: budget_categories
#
#  id               :integer          not null, primary key
#  budget_id        :integer          not null
#  category_id      :integer          not null
#  planned_cents    :integer          default(0), not null
#  planned_currency :string           default("USD"), not null
#  memo             :string           default("0"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "test_helper"

describe BudgetCategory do
  let(:budget_category) { BudgetCategory.new }

  it "must be valid" do
    value(budget_category).must_be :valid?
  end
end
