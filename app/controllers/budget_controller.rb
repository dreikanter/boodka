class BudgetController < ApplicationController
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  def show
    @date = DateTime.new(year, month)
  end

  def new
    @budget = Budget.new
  end

  def edit
  end

  def create
    @budget = Budget.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: 'Budget was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: 'Budget was successfully destroyed.' }
    end
  end

  private

  def set_budget
    @budget = Budget.where(year: year, month: month).first
  end

  def budget_params
    params[:budget]
  end

  def year
    params[:year] || Date.today.year
  end

  def month
    params[:month] || Date.today.month
  end
end
