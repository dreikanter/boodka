class PeriodsController < ApplicationController
  before_action :check_availability

  def show
    @date = base_date
    @categories = Category.ordered
    @periods = periods
   end

  private

  def periods
    Const::PERIODS_PER_PAGE.times.map { |i| period(base_date + i.month) }
  end

  def period(date)
    Period.at(date.year, date.month).decorate
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

  def time_frame
    base_date..(base_date + Const::PERIODS_PER_PAGE.month - 1.second)
  end

  def check_availability
    unless Account.any?
      redirect_to(accounts_path, alert: 'No accounts, nothing to budget.')
    end
    unless Category.any?
      redirect_to(categories_path, alert: 'Need categories to budget.')
    end
  end
end
