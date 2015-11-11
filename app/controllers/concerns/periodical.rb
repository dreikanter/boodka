module Periodical
  extend ActiveSupport::Concern

  def start_date
    @start_date ||= Date.new(year, month)
  end

  def year
    params[:year] ? Integer(params[:year]) : current_time.year
  end

  def month
    params[:month] ? Integer(params[:month]) : current_time.month
  end

  def current_time
    @current_time ||= Time.current
  end
end
