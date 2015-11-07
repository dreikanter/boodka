class PeriodsController < ApplicationController
  before_action :check_availability

  def show
    @categories = Category.ordered
    @periods = periods
   end

  private

  def periods
    get_period = -> (n) { period(first_period_date + n.month) }
    Const::PERIODS_PER_PAGE.times.map(&get_period)
  end

  def period(date)
    Period.at(date.year, date.month).decorate
  end

  def first_period_date
    @first_period_date ||= Date.new(year, month)
  end

  def current_time
    @current_time ||= Time.current
  end

  def year
    params[:year] ? Integer(params[:year]) : current_time.year
  end

  def month
    params[:month] ? Integer(params[:month]) : current_time.month
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
