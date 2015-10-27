# == Schema Information
#
# Table name: periods
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

require 'test_helper'

describe Period do
  let(:period) { Period.new }
  let(:current_period) { FactoryGirl.build :current_period }
  let(:previous_period) { FactoryGirl.build :previous_period }
  let(:ancient_period) { FactoryGirl.build :ancient_period }
  let(:today) { Date.today }
  let(:valid_category) { FactoryGirl.build :valid_category }
  let(:amount) { FactoryGirl.build :sample_amount_of_money }

  it 'must be valid' do
    value(period).must_be :valid?
  end

  it 'should have a date' do
    period = Period.new(year: today.year, month: today.month)
    period.date.must_equal Date.new(today.year, today.month)
  end

  it 'should populate fields' do
    start_at = DateTime.new(current_period.year, current_period.month, 1, 0, 0, 0)
    current_period.start_at.must_equal start_at
    current_period.end_at.must_equal (start_at + 1.month - 1.second)
  end

  it 'should spawn null objects' do
    Period.destroy_all
    null_period = Period.starting_at(today.year, today.month)
    null_period.wont_be_nil
    null_period.wont_be :persisted?
  end

  it 'should find existing instances' do
    current_period.save!
    result = Period.starting_at(current_period.year, current_period.month)
    result.must_equal current_period
  end

  it 'should spawn null budgets' do
    valid_category.save!
    budget = current_period.budget_for(valid_category)
    budget.wont_be_nil
    budget.amount.must_equal Money.new(0, ENV['base_currency'])
  end

  it 'should update budgets' do
    valid_category.save!
    created = current_period.budget!(valid_category.id, amount)

    created.must_be :persisted?
    created.must_equal current_period.budget_for(valid_category)

    updated = current_period.budget!(valid_category.id, amount * 2)
    updated.must_equal current_period.budget_for(valid_category)
  end

  it 'should point to existing previous period' do
    current_period.save!
    previous_period.save!
    current_period.previous_period.must_equal previous_period
  end

  it 'should accept splitted rare historical sequence' do
    current_period.save!
    ancient_period.save!
    current_period.previous_period.must_equal ancient_period
  end
end
