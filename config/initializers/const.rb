module Const
  CURRENCY_CODES = Money::Currency.all.map(&:iso_code)
  CURRENCY_CODES_SET = Set.new(CURRENCY_CODES)
  RATES_TTL_IN_SECONDS = 86_400
  RECENT_HISTORY_LENGTH = 20
  DATE_FORMAT = '%B %e'
  DATEPICKER_FORMAT = 'dd/mm/yyyy'
  DATEPICKER_FORMAT_PARSE = '%d/%m/%Y'
  TRANSACTION_DIRECTIONS = {
    outflow: 0,
    inflow: 1
  }
end
