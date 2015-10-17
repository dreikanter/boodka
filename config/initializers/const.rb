module Const
  ISO_CURRENCY_CODES = Money::Currency.all.map(&:iso_code)
end
