class ConvertedEquivalentCalculator < BasicCalculator
  def initialize(options = {})
    @accounts = options.fetch(:accounts, Account.all)
  end

  def calculate
    Hash[currencies.map { |c| [c, Calc.grand_total(currency: c)] }]
  end

  private

  def currencies
    @currencies ||= @accounts.map(&:currency).uniq
  end
end
