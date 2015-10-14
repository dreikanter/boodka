module Const
  ISO_CURRENCY_CODES = Money::Currency.all.map(&:iso_code)
  ISO_CURRENCY_CODE_LENGTH = 3
end
