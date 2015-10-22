module BudgetHelper
  def cell_id(prefix, year, month, category)
    [prefix, year, month, category].join('-')
  end
end
