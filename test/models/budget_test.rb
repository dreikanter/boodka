require "test_helper"

describe Budget do
  let(:budget) { Budget.new }

  it "must be valid" do
    value(budget).must_be :valid?
  end
end
