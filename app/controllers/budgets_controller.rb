class BudgetsController < ApplicationController
  def update
    @budget = Period.starting_at(year, month).budget!(cat_id, amount)
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
end
