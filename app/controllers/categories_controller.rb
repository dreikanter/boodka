class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:index, :create]
  before_action :new_category, only: [:index, :new]

  def create
    @category = Category.new(category_params)
    @category.save!
  rescue ActiveRecord::RecordInvalid => e
    render :new
  end

  def update
    render :edit unless @category.update(category_params)
  end

  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def permitted_params
    [:title, :memo]
  end

  def category_params
    params.require(:category).permit(permitted_params)
  end

  def load_categories
    @categories = Category.ordered
  end

  def new_category
    @category = Category.new
  end
end
