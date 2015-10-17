module Const
  ISO_CURRENCY_CODES = Money::Currency.all.map(&:iso_code)
  RECENT_HISTORY_LENGTH = 20
end
