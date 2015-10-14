class BalanceUpdate < ActiveRecord::Base
  delagate :currency, to: :account

  monetize :amount_cents, with_model_currency: :currency

  belong_to :account
end
