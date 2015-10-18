class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_url, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: 'Category updated'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category destroyed'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def permitted_params
    [:code, :title, :description]
  end

  def category_params
    params.require(:category).permit(permitted_params)
  end
end
