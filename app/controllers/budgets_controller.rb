class BudgetsController < ApplicationController
  def show
    @budget_category = budget_category(id)
  end

  def update
    # TODO: Persist data
    render json: nil, status: :ok
  end

  private

  def year
    Integer(params[:year])
  end

  def month
    Integer(params[:month])
  end

  def id
    Integer(params[:id])
  end

  def budget
    @budget ||= Budget.where(year: year, month: month).first || Budget.new(year: year, month: month)
  end
end
