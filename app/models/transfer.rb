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

  belongs_to :from_account, class_name: 'Account', foreign_key: :from_account_id
  belongs_to :to_account, class_name: 'Account', foreign_key: :to_account_id

  scope :history, -> { order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  after_create :create_transactions
  after_update :update_transactions

  private

  def accounts_are_different
    return unless from_account_id == to_account_id
    errors[:to_account_id] << 'destination account should be different'
  end

  def create_transactions
    Log.info 'Creating Transfer#transactions'
    Transaction.transaction do
      transactions.create!(from_params)
      transactions.create!(to_params)
    end
  end

  def update_transactions
    Log.info 'Updating Transfer#transactions'
    Transaction.transaction do
      transactions.where(direction: Const::OUTFLOW).update_all(from_params)
      transactions.where(direction: Const::INFLOW).update_all(to_params)
    end
  end

  def from_params
    transaction_params.merge(
      direction: Const::OUTFLOW,
      account_id: from_account_id
    )
  end

  def to_params
    transaction_params.merge(
      direction: Const::INFLOW,
      account_id: to_account_id
    )
  end

  TRANSACTION_PARAM_NAMES = %w(amount_cents amount_currency created_at)

  def transaction_params
    attributes.slice(*TRANSACTION_PARAM_NAMES)
  end
end
