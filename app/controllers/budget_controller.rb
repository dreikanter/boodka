class BudgetController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  def show
    @date = DateTime.new(year, month)
  end

  def value
    render json: { value: Random.new.integer }
  end

  private

  def set_budget
    @budget = Budget.where(year: year, month: month).first
  end

  def budget_params
    params[:budget]
  end

  def year
    params[:year] ? Integer(params[:year]) : Date.today.year
  end

  def month
    params[:month] ? Integer(params[:month]) : Date.today.month
  end
end
