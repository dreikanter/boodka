DEFAULT_CATEGORIES = %w(
  Bills
  Enterntainment
  Groceries
  Healthcare
  Household
  Phone & ISP
  Spendings
  Transportation
)

DEFAULT_CATEGORIES.each { |title| Category.create!(title: title) }
