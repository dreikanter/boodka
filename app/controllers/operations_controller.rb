class OperationsController < ApplicationController
  include Periodical

  OPS = %w(transaction reconciliation transfer)

  before_action :load_history

  private

  def load_history
    ops = operation_types.map { |klass| historical_frame(klass) }.flatten
    @history = ops.sort { |a, b| b.created_at <=> a.created_at }
  end

  def operation_types
    fail 'Illegal operation type' if operation && !OPS.include?(operation)
    (operation && [operation] || OPS).map { |n| n.classify.constantize }
  end

  def historical_frame(model)
    model.history.where(historical_frame_criteria(model))
  end

  def historical_frame_criteria(model)
    criteria = { created_at: time_frame }
    expenses = (model == Transaction && category_id)
    criteria.merge(expenses ? { category_id: category_id } : {})
  end

  def time_frame
    start_date.beginning_of_month..start_date.end_of_month
  end

  def category_id
    params[:category_id]
  end

  def operation
    params[:operation]
  end
end
