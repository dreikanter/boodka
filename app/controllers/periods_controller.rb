class PeriodsController < ApplicationController
  before_action :check_availability

  def show
    @categories = Category.ordered
    @periods = periods
    @history = history(@periods.first.start_at..@periods.last.end_at)
   end

  private

  def periods
    to_date = -> (n) { first_period_date + n.month }
    to_period = -> (d) { Period.at(d.year, d.month).decorate }
    Const::PERIODS_PER_PAGE.times.map(&to_date).map(&to_period)
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
    message = 'No accounts, nothing to budget.'
    redirect_to(accounts_path, alert: message) unless Account.any?
    message = 'Need categories to budget.'
    redirect_to(categories_path, alert: message) unless Category.any?
  end

  HISTORICAL_ENTITIES = [Transaction, Reconciliation, Transfer]

  def history(time_frame)
    historical_frame = -> (model) { model.history.where(created_at: time_frame) }
    by_creation = -> (a, b) { b.created_at <=> a.created_at }
    HISTORICAL_ENTITIES.map(&historical_frame).flatten.sort(&by_creation)
  end
end
