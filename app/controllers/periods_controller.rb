class PeriodsController < ApplicationController
  def show
    @date = base_date
    @categories = Category.all
    @periods = periods
   end

  private

  def periods
    Const::PERIODS_PER_PAGE.times.map { |i| period(base_date + i.month) }
  end

  def period(date)
    Period.starting_at(date.year, date.month).decorate
  end

  def base_date
    @base_date ||= DateTime.new(year, month)
  end

  def year
    params[:year] ? Integer(params[:year]) : Date.today.year
  end

  def month
    params[:month] ? Integer(params[:month]) : Date.today.month
  end
end
