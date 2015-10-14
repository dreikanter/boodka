module AmountOfMoney
  extend ActiveSupport::Concern

  included do
    monetize :amount_cents, with_model_currency: :currency

    validates :currency, inclusion: {
      in: Const::ISO_CURRENCY_CODES,
      message: 'Invalid currency code'
    }

    validates :currency, length: { is: Const::ISO_CURRENCY_CODE_LENGTH }
  end
end
