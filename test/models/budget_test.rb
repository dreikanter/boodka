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

require "test_helper"

describe Budget do
  let(:budget) { Budget.new }

  it "must be valid" do
    value(budget).must_be :valid?
  end
end
