require "test_helper"

describe Account do
  let(:account) { Account.new(title: 'Test', currency: 'USD') }

  it 'must be valid' do
    value(account).must_be :valid?
  end

  it '#total' do
    Account.destroy_all
    test_account = account.save
    # binding.pry
    test_account.total.must_be 0
  end
end
