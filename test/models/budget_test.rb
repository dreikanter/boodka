# == Schema Information
#
# Table name: budgets
#
#  id              :integer          not null, primary key
#  period_id       :integer          not null
#  category_id     :integer          not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  memo            :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

describe Budget do
  let(:budget) { FactoryGirl.build :budget }
  let(:usd_account) { FactoryGirl.create :usd_account }
  let(:eur_account) { FactoryGirl.create :eur_account }
  let(:rub_account) { FactoryGirl.create :rub_account }

  EXPENSES = [100, 200, 300]

  it 'must be valid' do
    budget.must_be :valid?
  end

  it 'must calculate expense' do
    date = Date.new(budget.year, budget.month, 1)
    EXPENSES.each do |value|
      Transaction.create!(
        account: usd_account,
        amount_cents: value,
        amount_currency: budget.amount_currency,
        category: budget.category,
        direction: Const::OUTFLOW
      )
    end

    expected = EXPENSES.map { |n| Money.new(n, budget.amount_currency) }.sum
    budget.actual.must_equal expected
  end

  it 'must calculate expense in alternative currency' do
    date = Date.new(budget.year, budget.month, 1)
    EXPENSES.each do |value|
      Transaction.create!(
        account: usd_account,
        amount_cents: value,
        amount_currency: usd_account.currency,
        category: budget.category,
        direction: Const::OUTFLOW
      )
    end

    expected = EXPENSES.map { |n| Money.new(n, usd_account.currency).exchange_to(budget.amount_currency) }.sum
    budget.actual.must_equal expected
  end

  it 'must calculate balance' do
    date = Date.new(budget.year, budget.month, 1)
    currency = budget.amount_currency

    EXPENSES.each do |value|
      Transaction.create!(
        account: usd_account,
        amount_cents: value,
        amount_currency: currency,
        category: budget.category,
        direction: Const::OUTFLOW
      )
    end

    expected = budget.amount - EXPENSES.map { |n| Money.new(n, currency) }.sum
    budget.balance.must_equal expected
  end

  it 'understand multicurrency transactions' do
    date = Date.new(budget.year, budget.month, 1)
    currency = budget.amount_currency

    source = [[100, usd_account], [200, rub_account], [300, eur_account]]
    source.each do |amount, account|
      Transaction.create!(
        account: account,
        amount_cents: amount,
        amount_currency: account.currency,
        category: budget.category,
        direction: Const::OUTFLOW
      )
    end

    expected = budget.amount - source.map { |amount, account| Money.new(amount, account.currency).exchange_to(budget.amount_currency) }.sum
    budget.balance.must_equal expected
  end
end
