# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  currency   :string           not null
#  title      :string           not null
#  memo       :string           default(""), not null
#  default    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

describe Account do
  let(:new_account) { FactoryGirl.build :account }
  let(:new_default_account) { FactoryGirl.build :default_account }
  let(:persisted_account) { FactoryGirl.create :account }

  INFLOW = Const::TRANSACTION_DIRECTIONS[:inflow]
  OUTFLOW = Const::TRANSACTION_DIRECTIONS[:outflow]

  it 'must be valid' do
    new_account.must_be :valid?
  end

  it 'must know its total' do
    persisted_account.transactions.destroy_all
    persisted_account.total.must_equal 0
  end

  it 'must calculate total' do
    account = persisted_account
    values = [-5.5, -1.1, 3.3, 10.01]
    direction = -> (value) { (value > 0) ? INFLOW : OUTFLOW }
    amount = -> (value) { Money.new(value.abs, account.currency) }

    values.each do |value|
      account.transactions.create(
        amount: amount.call(value),
        direction: direction.call(value)
      )
    end

    expected = values.map { |value| Money.new(value, account.currency) }.sum
    account.total.must_equal expected
  end

  it 'must have only one default' do
    Account.destroy_all
    3.times { FactoryGirl.create(:default_account) }
    Account.where(default: true).count.must_equal 1
  end

  it 'should update default flag' do
    initial_default = FactoryGirl.create(:default_account)
    Account.where(default: true).first.must_equal initial_default
    new_default = FactoryGirl.create(:default_account)
    Account.where(default: true).first.must_equal new_default
  end
end
