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
#  direction                  :integer          default(0), not null
#  rate                       :float            default(1.0), not null
#  category_id                :integer
#  transfer_id                :integer
#  memo                       :string           default(""), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Transaction < ActiveRecord::Base
  monetize :amount_cents,
           with_model_currency: :amount_cents_currency

  monetize :calculated_amount_cents,
           with_model_currency: :calculated_amount_currency

  validates :amount_cents, numericality: { greater_than: 0 }

  validates :amount_currency,
            :calculated_amount_currency,
            inclusion: { in: Const::CURRENCY_CODES }

  validates :account_id, presence: true

  enum direction: Const::TRANSACTION_DIRECTIONS

  belongs_to :category
  belongs_to :account
  belongs_to :transfer

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }
  scope :outflows, -> { where(direction: Const::OUTFLOW) }
  scope :inflows, -> { where(direction: Const::INFLOW) }

  before_create :refresh_rate
  before_update :refresh_rate_if_currency_changed
  before_save :refresh_calculated_amount

  delegate :currency, to: :account, prefix: :account

  def transfer?
    transfer_id.present?
  end

  def uncategorized?
    category.nil?
  end

  private

  def refresh_rate
    self.rate = (amount_currency == account_currency) ? 1 : load_rate
  end

  def refresh_rate_if_currency_changed
    refresh_rate if amount_currency_changed?
  end

  def load_rate
    Log.info "loading new rate #{amount_currency}-#{account_currency}"
    Money.default_bank.get_rate(amount_currency, account_currency)
  end

  def refresh_calculated_amount
    self.calculated_amount_cents = Integer(amount_cents * rate)
  end
end
