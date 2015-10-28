class TotalsPerCurrencyCalculator < BasicCalculator
  def initialize(options = {})
    @accounts = options.fetch(:accounts, Account.all)
  end

  def calculate
    groups = account_totals.group_by { |item| item[:currency] }
    Hash[groups.map { |k, v| [k, v.map { |a| a[:amount] }.sum] }]
  end

  private

  def account_totals
    total = -> (a) { Calc.account_total(account: a) }
    @accounts.map { |a| { currency: a.currency, amount: total.call(a) } }
  end

  # def converted_equivalent(totals_per_currency)
  #   Hash[totals_per_currency.map { |currency, amount| [currency, totals_per_currency.values.sum.exchange_to(currency)] }]
  # end
end
