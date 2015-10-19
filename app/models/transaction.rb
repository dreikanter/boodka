# == Schema Information
#
# Table name: transactions
#
#  id                         :integer          not null, primary key
#  account_id                 :integer          not null
#  amount_cents               :integer          default(0), not null
#  amount_currency            :string           default("USD"), not null
#  calculated_amount_cents    :integer          default(0), not null
#  calculated_amount_currency :string           default("USD"), not null
#  rate                       :float            default(1.0), not null
#  category_id                :integer
#  transfer_id                :integer
#  description                :string           default(""), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Transaction < ActiveRecord::Base
  monetize :amount_cents, with_model_currency: :currency

  validates :amount_currency,
            :calculated_amount_currency,
            inclusion: { in: Const::CURRENCY_CODES }

  validates :account_id, presence: true

  belongs_to :category
  belongs_to :account
  belongs_to :transfer

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  def transfer?
    transfer_id.present?
  end
end
