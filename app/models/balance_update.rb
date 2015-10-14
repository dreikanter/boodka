class BalanceUpdate < ActiveRecord::Base
  delegate :currency, to: :account

  monetize :amount_cents, with_model_currency: :currency

  belongs_to :account
end
