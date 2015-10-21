# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  currency    :string           not null
#  title       :string           not null
#  description :string           default(""), not null
#  default     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Account < ActiveRecord::Base
  validates :title, presence: true
  validates :default, inclusion: { in: [true, false] }
  validates :currency, inclusion: { in: Const::CURRENCY_CODES }

  has_many :transactions, dependent: :destroy
  has_many :planned_transactions, dependent: :destroy
  has_many :reconciliations, dependent: :destroy

  scope :ordered, -> { order(:created_at) }

  before_save :drop_old_default_if_needed

  def self.default!(id)
    Account.update(id, default: true)
  end

  def total
    last_rec = Reconciliation.last_for(self)
    since = last_rec.created_at
    last_rec.amount + inflow(since) - outflow(since)
  end

  private

  def inflow(since)
    sum(since, Const::TRANSACTION_DIRECTIONS[:inflow])
  end

  def outflow(since)
    sum(since, Const::TRANSACTION_DIRECTIONS[:outflow])
  end

  def sum(since, direction)
    flow = transactions.where(direction: direction)
    sum = flow.where('created_at >= ?', since).sum(:calculated_amount_cents)
    Money.new(sum || 0, currency)
  end

  def drop_old_default_if_needed
    return unless default && default_changed?
    Account.where(default: true).update_all(default: false)
  end
end
