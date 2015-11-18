class AccountsPerCurrencyCalculator < BasicCalculator
  def initialize(options = {})
    @accounts = options.fetch(:accounts, Account.all)
  end

  def calculate
    groups = @accounts.group_by { |item| item.currency }
    Hash[groups.map { |k, v| [k, v.count] }]
  end
end
