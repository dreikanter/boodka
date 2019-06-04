require "test_helper"

describe TotalExpenseCalculator do
  let(:outflow_transaction) { FactoryBot.build(:outflow_transaction) }
  let(:current_period) { FactoryBot.build(:current_period) }
  let(:zero) { FactoryBot.build(:zero) }

  it 'is zero when there are not transactions' do
    Transaction.destroy_all
    Calc.total_expense(period: current_period).must_equal zero
  end

  it 'is calculate sum' do
    Transaction.destroy_all
    transaction = outflow_transaction
    transaction.save!
    # binding.pry
    # Calc.total_expense(period: current_period).must_equal zero
  end
end
