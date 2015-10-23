class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]

  def show
    @date = DateTime.new(year, month)
  end

  def value
    render json: { value: Random.new.integer }
  end

  private

  def set_period
    @period = Period.where(year: year, month: month).first
  end

  def period_params
    params[:period]
  end

  def year
    params[:year] ? Integer(params[:year]) : Date.today.year
  end

  def month
    params[:month] ? Integer(params[:month]) : Date.today.month
  end
end
