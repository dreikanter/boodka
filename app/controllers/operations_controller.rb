class OperationsController < ApplicationController
  include Periodical

  before_action :load_history

  private

  OPS = [Transaction, Reconciliation, Transfer]

  def load_history
    historical_frame = -> (model) { model.history.where(created_at: time_frame) }
    by_creation = -> (a, b) { b.created_at <=> a.created_at }
    @history = OPS.map(&historical_frame).flatten.sort(&by_creation)
  end

  def time_frame
    start_date.beginning_of_month..start_date.end_of_month
  end
end
