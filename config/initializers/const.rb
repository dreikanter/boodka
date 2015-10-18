module Const
  CURRENCY_CODES = Money::Currency.all.map(&:iso_code)
  CURRENCY_CODES_SET = Set.new(CURRENCY_CODES)
  RECENT_HISTORY_LENGTH = 20
  DATE_FORMAT = '%B %e'
  DATEPICKER_FORMAT = 'dd/mm/yyyy'
  DATEPICKER_FORMAT_PARSE = '%d/%m/%Y'
end
