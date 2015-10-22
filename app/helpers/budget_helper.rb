module BudgetHelper
  def cell_id(date, category)
    "#{date.strftime('%Y-%m')}-#{category.id}"
  end
end
