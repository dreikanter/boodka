module Currency
  extend ActiveSupport::Concern

  included do
    validates :currency, inclusion: {
      in: Const::CURRENCY_CODES,
      message: 'Invalid currency code'
    }
  end
end
