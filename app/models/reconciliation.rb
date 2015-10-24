# == Schema Information
#
# Table name: reconciliations
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Reconciliation < ActiveRecord::Base
  validates :account_id, :amount, presence: true

  monetize :amount_cents, with_model_currency: :currency

  belongs_to :account

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order('created_at asc, updated_at desc') }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  after_initialize :defaults

  def currency
    account.try(:currency)
  end

  def self.last_for(account)
    where(account: account).last || ZeroReconciliation.new(account)
  end

  def defaults
    self.amount_cents ||= 0
  end
end
