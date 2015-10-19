require 'money/bank/google_currency'

MoneyRails.configure do |config|
  config.default_bank = Money::Bank::GoogleCurrency.new
  Money::Bank::GoogleCurrency.ttl_in_seconds = Const::RATES_TTL_IN_SECONDS
end
