# == Schema Information
#
# Table name: budgets
#
#  id            :integer          not null, primary key
#  period_id     :integer          not null
#  category_id   :integer          not null
#  year          :integer          not null
#  month         :integer          not null
#  start_at      :datetime         not null
#  end_at        :datetime         not null
#  amount_cents  :integer          default(0), not null
#  spent_cents   :integer          default(0), not null
#  balance_cents :integer          default(0), not null
#  currency      :string           not null
#  memo          :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

describe Budget do
  let(:budget) { FactoryBot.build :budget }
  let(:previous_budget) { FactoryBot.build :previous_budget }
  let(:ancient_budget) { FactoryBot.build :ancient_budget }

  let(:usd_account) { FactoryBot.create :usd_account }
  let(:eur_account) { FactoryBot.create :eur_account }
  let(:rub_account) { FactoryBot.create :rub_account }

  let(:current_period) { FactoryBot.create :current_period }
  let(:previous_period) { FactoryBot.create :previous_period }
  let(:category) { FactoryBot.create :valid_category }

  EXPENSES = [100, 200, 300]
  DELTA_PERCENTAGE = 0.1

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
    # TODO: Use fixed rates

    Transaction.destroy_all
    Budget.destroy_all

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
    budget.actual.must_be_close_to(expected, expected * DELTA_PERCENTAGE)
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
    # TODO: Use fixed rates

    Transaction.destroy_all
    Budget.destroy_all

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
    budget.balance.must_be_close_to(expected, (expected * DELTA_PERCENTAGE).abs)
  end

  it 'must filter transactions' do
    Transaction.destroy_all

    [-2, -1, 0, 0, 1, 2].each do |n|
      Transaction.create!(
        account: usd_account,
        amount_cents: 1,
        amount_currency: usd_account.currency,
        category: budget.category,
        direction: Const::OUTFLOW,
        created_at: budget.date + n.month
      )
    end

    actual = budget.transactions.map(&:id).sort
    timeframe = budget.date..(budget.date + 1.month - 1.second)
    expected = Transaction.where(created_at: timeframe).map(&:id).sort

    actual.must_equal expected
  end

  it 'must calculate balance based on previous period' do
    Period.destroy_all
    Budget.destroy_all
    Transaction.destroy_all

    amount_cents = 500
    currency = Money::Currency.new(ENV['base_currency'])
    expected = Money.new(amount_cents, currency)

    current_budget = current_period.budget_cents!(category.id, amount_cents)
    previous_budget = previous_period.budget_cents!(category.id, amount_cents)
    previous_budget.balance.must_equal expected
  end
end
