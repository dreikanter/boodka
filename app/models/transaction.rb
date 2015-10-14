class Transaction < ActiveRecord::Base
  monetize :amount_cents, with_model_currency: :currency
end
