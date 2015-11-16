module PathHelper
  def ops_path(operation)
    year = operation.created_at.try(:year) || now.year
    month = operation.created_at.try(:month) || now.month
    operations_path(year, month)
  end

  def current_period_path
    period_path(now.year, now.month)
  end

  def current_operations_path
    operations_path(now.year, now.month)
  end

  private

  def now
    @now ||= Time.current
  end
end
