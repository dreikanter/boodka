class BudgetsController < ApplicationController
  def update
    @budget = period.budget_cents!(cat_id, amount_cents)
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

  def period
    Period.starting_at(year, month)
  end
end
