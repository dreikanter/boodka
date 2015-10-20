require "test_helper"

describe Account do
  let(:new_account) { FactoryGirl.build :account }
  let(:new_default_account) { FactoryGirl.build :default_account }
  let(:persisted_account) { FactoryGirl.create :account }

  it 'must be valid' do
    new_account.must_be :valid?
  end

  it 'must know its total' do
    persisted_account.total.must_equal 0
  end

  it 'must calculate the sum of transactions' do
    values = -2..2
    values.each { |n| persisted_account.transactions.create(amount_cents: n) }
    persisted_account.total.cents.must_equal values.sum
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
