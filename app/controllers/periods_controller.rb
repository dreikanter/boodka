class PeriodsController < ApplicationController
  include Periodical

  before_action :redirect_from_root, only: :show
  before_action :check_availability

  def show
    @periods = Facade.periods(
      periods: load_periods,
      categories: Category.ordered
    )
  end

  def update
    period = Period.at!(year, month)
    Category.ordered.each { |c| period.budget_for(c).copy_prev! }
  end

  private

  def load_periods
    to_date = -> (n) { start_date + n.month }
    to_period = -> (d) { Period.at(d.year, d.month).decorate }
    Const::PERIODS_PER_PAGE.times.map(&to_date).map(&to_period)
  end

  def check_availability
    message = 'No accounts, nothing to budget.'
    redirect_to(accounts_path, alert: message) unless Account.any?
    message = 'Need categories to budget.'
    redirect_to(categories_path, alert: message) unless Category.any?
  end

  def redirect_from_root
    return if params[:year].present? && params[:month].present?
    redirect_to period_path(year, month)
  end
end
