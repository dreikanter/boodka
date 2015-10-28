class BudgetsController < ApplicationController
  def update
    @budget = Budget.at!(year, month, cat_id)
    @budget.update(amount_cents: amount_cents)
    @budget.refresh!
    @budget = @budget.decorate
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
end
