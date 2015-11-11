class PeriodsController < ApplicationController
  include Periodical

  before_action :check_availability, :load_categories, :load_periods

  private

  def load_periods
    to_date = -> (n) { start_date + n.month }
    to_period = -> (d) { Period.at(d.year, d.month).decorate }
    @periods = Const::PERIODS_PER_PAGE.times.map(&to_date).map(&to_period)
  end

  def load_categories
    @categories = Category.ordered
  end

  def check_availability
    message = 'No accounts, nothing to budget.'
    redirect_to(accounts_path, alert: message) unless Account.any?
    message = 'Need categories to budget.'
    redirect_to(categories_path, alert: message) unless Category.any?
  end
end
