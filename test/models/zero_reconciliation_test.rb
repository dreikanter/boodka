# == Schema Information
#
# Table name: reconciliations
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "test_helper"

describe ZeroReconciliation do
  before do
    @account = Account.create(title: 'Test', currency: 'USD')
  end

  after do
    @account.destroy!
  end

  let(:zero_rec) { ZeroReconciliation.new(@account) }

  it 'must be zero' do
    zero_rec.amount_cents.must_equal 0
  end

  it 'must be valid' do
    zero_rec.must_be :valid?
  end
end
