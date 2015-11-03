class BudgetsController < ApplicationController
  def update
    budget = Budget.at!(year, month, cat_id)
    budget.update(amount_cents: amount_cents)
    budget.refresh!
    render json: updated_budget(budget)
  end

  private

  def year
    Integer(params[:year])
  end

  def month
    Integer(params[:month])
  end

  def cat_id
    Integer(params[:id])
  end

  def amount
    params[:amount].to_f
  end

  def amount_cents
    amount * Integer(ENV['subunit_to_unit'])
  end

  def new_values(budget)
    budget ? budget_data(budget).merge(period_data(budget.period)) : {}
  end

  def updated_budget(budget)
    # TODO: Use Const::PERIODS_PER_PAGE
    new_values(budget).merge(new_values(budget.next_budget))
  end

  def budget_data(budget)
    {
      sel(budget, :amount)  => budget.amount.to_f,
      sel(budget, :spent)   => budget.spent.to_f,
      sel(budget, :balance) => budget.balance.to_f
    }
  end

  def period_data(period)
    period.nil? ? {} : {
      sel(period, :total_budgeted)      => period.total_budgeted.to_f,
      sel(period, :total_expense)       => period.total_expense.to_f,
      sel(period, :total_balance)       => period.total_balance.to_f,
      sel(period, :available_to_budget) => period.available_to_budget.to_f
    }
  end

  def sel(object, field)
    Selector.for(object, field)
  end
end
