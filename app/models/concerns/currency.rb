module Currency
  extend ActiveSupport::Concern

  included do
    validates :currency, inclusion: {
      in: Const::ISO_CURRENCY_CODES,
      message: 'Invalid currency code'
    }

    validates :currency, length: { is: Const::ISO_CURRENCY_CODE_LENGTH }
  end
end
