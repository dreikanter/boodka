module Currency
  extend ActiveSupport::Concern

  included do
    validates :currency, inclusion: {
      in: Const::ISO_CURRENCY_CODES,
      message: 'Invalid currency code'
    }
  end
end
