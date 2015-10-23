class BudgetsController < ApplicationController
  def index
    @budget_categories = find_budget_categories
  end

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

  def budget_category(id)
    find_budget_category(id) || new_budget_category(id)
  end

  def find_budget_category(id)
    budget.categories.where(id: id).first
  end

  def new_budget_category(id)
    BudgetCategory.new(budget: budget, category_id: id)
  end

  def find_budget_categories
    Category.pluck(:id).map { |id| budget_category(id) }
  end
end
