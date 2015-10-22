class BudgetCategoriesController < ApplicationController
  def show
    @budget_category = budget_category
  end

  def update
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
    @budget ||= Budget.where(year: year, month: month).first || Budget.new
  end

  def budget_category
    @budget_category ||= find_budget_category || new_budget_category
  end

  def find_budget_category
    budget.categories.where(id: id).first
  end

  def new_budget_category
    BudgetCategory.new(budget: budget, category_id: id)
  end
end
