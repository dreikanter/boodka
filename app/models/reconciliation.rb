class Reconciliation < ActiveRecord::Base
  validates :account_id, :amount, presence: true

  monetize :amount_cents, with_model_currency: :currency

  belongs_to :account

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  def currency
    account.try(:currency)
  end
end
