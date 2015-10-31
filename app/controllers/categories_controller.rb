class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:index, :create]
  before_action :new_category, only: [:index, :new]

  def create
    @category = Category.new(category_params)
    begin
      @category.save!
      redirect_to categories_path, notice: 'Category created'
    rescue => e
      flash.now[:alert] = e.message
      render :index
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category updated'
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
