class NullBudget < Budget
  def self.for(period, category)
    new(period: period, category: category)
  end
end
