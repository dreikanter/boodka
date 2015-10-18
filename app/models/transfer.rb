# == Schema Information
#
# Table name: transfers
#
#  id                  :integer          not null, primary key
#  from_transaction_id :integer          not null
#  to_transaction_id   :integer          not null
#  from_account_id     :integer          not null
#  to_account_id       :integer          not null
#  amount_cents        :decimal(8, )     default(0), not null
#  currency            :string           not null
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Transfer < ActiveRecord::Base
  include Currency

  monetize :amount_cents, with_model_currency: :currency

  validates :from_transaction_id,
            :to_transaction_id,
            :from_account_id,
            :to_account_id, presence: true

  before_validation :build

  scope :history, -> { order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  def default_description
    "Transfer #{amount} #{currency} from " \
      "#{from_account.title} to #{to_account.title}"
  end

  private

  TRANSFER_CATEGORY_ID = 0

  def build
    return if persisted?
    create_transactions
    update_description
  end

  private

  def create_transactions
    Transfer.transaction do
      from = create_withdraw_transaction
      to = create_deposit_transaction

      self.from_transaction_id = from.id
      self.to_transaction_id = to.id

      self.from_account_id = from.account_id
      self.to_account_id = to.account_id
    end
  end

  def create_withdraw_transaction
    Transaction.create!(
      account_id: from_account_id,
      amount_cents: -amount_cents,
      currency: currency,
      category_id: TRANSFER_CATEGORY_ID,
      description: 'Transfer'
    )
  end

  def create_deposit_transaction
    Transaction.create!(
      account_id: to_account_id,
      amount_cents: amount_cents,
      currency: currency,
      category_id: TRANSFER_CATEGORY_ID,
      description: 'Transfer'
    )
  end

  def update_description
    self.description = default_description if description.blank?
  end

  def from_account
    Account.find(from_account_id)
  end

  def to_account
    Account.find(to_account_id)
  end
end
