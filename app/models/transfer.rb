# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  memo            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  from_account_id :integer          not null
#  to_account_id   :integer          not null
#

class Transfer < ActiveRecord::Base
  monetize :amount_cents

  validates :amount_cents,
            :amount_currency,
            :from_account_id,
            :to_account_id, presence: true

  validate :accounts_are_different

  has_many :transactions, dependent: :destroy

  scope :history, -> { order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  after_create :create_transactions
  after_update :update_transactions

  private

  def create_transactions
    Transaction.transaction do
      transactions.create!(from_transaction_params)
      transactions.create!(to_transaction_params)
    end
  end

  def from_transaction_params
    transaction_params.merge(direction: :outflow, account_id: from_account_id)
  end

  def to_transaction_params
    transaction_params.merge(direction: :inflow, account_id: to_account_id)
  end

  TRANSACTION_PARAM_NAMES = %w(amount_cents amount_currency created_at)

  def transaction_params
    attributes.slice(*TRANSACTION_PARAM_NAMES)
  end

  def accounts_are_different
    return unless from_account_id == to_account_id
    errors[:to_account_id] << 'destination account should be different'
  end

  def update_transactions
    Transaction.transaction do
      Transaction.update(from_account_id, from_transaction_params)
      Transaction.update(to_account_id, to_transaction_params)
    end
  end
end
