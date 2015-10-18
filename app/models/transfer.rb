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

  validates :from_transaction_id, :to_transaction_id, presence: true
  validates :from_account_id, :to_account_id, presence: true

  has_one :from_account, class_name: Account, foreign_key: :id
  has_one :to_account, class_name: Account, foreign_key: :id

  has_one :from_transaction, class_name: Transaction,
          foreign_key: :id, dependent: :destroy
  has_one :to_transaction, class_name: Transaction,
          foreign_key: :id, dependent: :destroy

  before_validation :populate

  scope :history, -> { order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  def default_description
    "Transfer #{amount} #{currency} from #{withdraw.account.title} to #{deposit.account.title}"
  end

  private

  TRANSFER_CATEGORY_ID = 0

  def populate
    create_transactions
    update_description
  end

  def create_transactions
    Transfer.transaction do
      self.from_transaction_id = withdraw.id
      self.to_transaction_id = deposit.id
      self.from_account_id = withdraw.account_id
      self.to_account_id = deposit.account_id
    end
  end

  def withdraw
    @withdraw ||= Transaction.create!(
      account_id: from_account_id,
      amount_cents: -amount_cents,
      currency: currency,
      category_id: TRANSFER_CATEGORY_ID,
      description: 'Transfer'
    )
  end

  def deposit
    @deposit ||= Transaction.create!(
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
end
