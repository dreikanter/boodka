# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  currency   :string
#  amount     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  monetize :amount_cents, with_model_currency: :currency

  validates :currency, inclusion: {
    in: Const::ISO_CURRENCY_CODES,
    message: 'Invalid currency code'
  }

  validates :currency, length: { is: Const::ISO_CURRENCY_CODE_LENGTH }
end
