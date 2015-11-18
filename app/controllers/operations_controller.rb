class OperationsController < ApplicationController
  include Periodical

  OPS = %w(transaction reconciliation transfer)

  before_action :redirect_from_root, only: :show
  before_action :validate_params, :load_history

  private

  def load_history
    @ops = Facade.operations(
      filtered: filtered?,
      types: operation_types,
      category: category,
      records: operations,
      reset_filter_path: reset_filter_path
    )
  end

  def filtered?
    category.present? || (operation_types != OPS)
  end

  def operations
    order = -> (a, b) { b.created_at <=> a.created_at }
    operation_types.map { |model| scope(model) }.flatten.sort(&order)
  end

  def operation_types
    operation.present? ? [operation] : OPS
  end

  def scope(model)
    model.classify.constantize.history.where(enabled_scope_criteria)
  end

  def available_criteria
    {
      created_at: time_frame,
      category: category,
      direction: direction
    }
  end

  def enabled_scope_criteria
    available_criteria.delete_if { |_, v| v.nil? }
  end

  def time_frame
    start_date.beginning_of_month..start_date.end_of_month
  end

  def category
    return unless category_id
    @category ||= Category.find(category_id)
  end

  def category_id
    params[:category_id]
  end

  def direction
    params[:direction]
  end

  def operation
    params[:operation]
  end

  def validate_params
    valisate_operation
    validate_direction
  end

  def valisate_operation
    fail 'Illegal operation type' if operation && !OPS.include?(operation)
  end

  def validate_direction
    dirs = Const::DIRECTIONS.values
    fail 'Illegal direction' if direction && !dirs.include?(Integer(direction))
  end

  def redirect_from_root
    return if params[:year].present? && params[:month].present?
    redirect_to operations_path(year, month)
  end

  def reset_filter_path
    return current_operations_path unless params[:year].present?
    operations_path(params[:year], params[:month])
  end
end
