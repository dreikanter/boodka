module Const
  CURRENCY_CODES = Money::Currency.all.map(&:iso_code)
  CURRENCY_CODES_SET = Set.new(CURRENCY_CODES)
  RATES_TTL_IN_SECONDS = 86_400
  RECENT_HISTORY_LENGTH = 20
  SHORT_DATE_FORMAT = '%B %e'
  BUDGET_DATE_FORMAT = '%B %Y'
  DATEPICKER_FORMAT = 'dd/mm/yyyy'
  DATEPICKER_FORMAT_PARSE = '%d/%m/%Y'
  PERIODS_PER_PAGE = 2
  TRANSACTION_DIRECTIONS = {
    outflow: 0,
    inflow: 1
  }
end
