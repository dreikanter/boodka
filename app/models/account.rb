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

  has_many :transactions
  has_many :planned_transactions
  has_many :reconciliations

  scope :ordered, -> { order(:created_at) }

  def self.default!(id)
    Account.transaction do
      Account.update_all(default: false)
      Account.update(id, default: true)
    end
  end

  def total
    last_rec = Reconciliation.last_for(self)
    ts = Transaction.where('created_at > ?', last_rec.created_at)
    last_rec.amount + ts.map(&:calculated_amount).reduce(:+)
  end
end
