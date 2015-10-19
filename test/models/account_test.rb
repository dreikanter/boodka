require "test_helper"

describe Account do
  before do
    @account = Account.create(title: 'Test', currency: 'USD')
  end

  after do
    @account.destroy!
  end

  it 'must be valid' do
    @account.must_be :valid?
  end

  it 'must know its total' do
    @account.total.must_equal 0
  end

  it 'must calculate the sum of transactions' do
    values = -2..2
    values.each { |n| @account.transactions.create(amount_cents: n) }
    @account.total.cents.must_equal values.sum
  end
end
