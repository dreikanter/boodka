# == Schema Information
#
# Table name: reconciliations
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  delta_cents  :integer          default(0), not null
#

class Reconciliation < ActiveRecord::Base
  validates :account_id, :amount, presence: true

  monetize :amount_cents, with_model_currency: :currency
  monetize :delta_cents, with_model_currency: :currency

  belongs_to :account

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order('created_at desc, updated_at desc') }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }

  after_initialize :defaults
  after_save :calculate_delta

  def currency
    @currency ||= account.try(:currency)
  end

  def self.last_for(account)
    where(account: account).last || Reconciliation.new(account: account)
  end

  def defaults
    self.amount_cents ||= 0
  end

  private

  def calculate_delta
    total = Calc.total(account: account, at: created_at)
    update_column(:delta_cents, amount_cents - total.cents)
  end
end
