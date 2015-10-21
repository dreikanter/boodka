require "test_helper"

describe BudgetCategory do
  let(:budget_category) { BudgetCategory.new }

  it "must be valid" do
    value(budget_category).must_be :valid?
  end
end
