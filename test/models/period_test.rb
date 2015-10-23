require "test_helper"

describe Period do
  let(:period) { Period.new }

  it "must be valid" do
    value(period).must_be :valid?
  end
end
