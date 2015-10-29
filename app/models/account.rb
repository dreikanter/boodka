# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  currency   :string           not null
#  title      :string           not null
#  memo       :string           default(""), not null
#  default    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  validates :title, presence: true
  validates :default, inclusion: { in: [true, false] }
  validates :currency, inclusion: { in: Const::CURRENCY_CODES }

  has_many :transactions, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :reconciliations, dependent: :destroy

  scope :ordered, -> { order(:created_at) }

  before_save :drop_old_default_if_needed

  def self.default!(id)
    Account.update(id, default: true)
  end

  private

  def drop_old_default_if_needed
    return unless default && default_changed?
    Account.where(default: true).update_all(default: false)
  end
end
