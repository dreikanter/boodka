class TotalConvertedEquivalentsCalculator < BasicCalculator
  def initialize(options = {})
    @totals = options.fetch(:totals_per_currency)
  end

  def calculate
    sum = @totals.values.sum
    Hash[@totals.keys.map { |c| [c, sum.exchange_to(c)] }]
  end
end
