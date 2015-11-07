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
  validates :title, uniqueness: { case_sensitive: false }
  validates :default, inclusion: { in: [true, false] }
  validates :currency, inclusion: { in: Const::CURRENCY_CODES }

  has_many :transactions, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :reconciliations, dependent: :destroy

  scope :ordered, -> { order(:title) }

  before_save :drop_old_default_if_needed
  after_create :ensure_default_present

  def self.default!(id)
    Account.update(id, default: true)
  end

  def self.default
    where(default: true).first
  end

  def self.default_id
    where(default: true).pluck(:id).first
  end

  private

  def drop_old_default_if_needed
    return unless default && default_changed?
    Account.where(default: true).update_all(default: false)
  end

  def ensure_default_present
    self.class.default!(id) unless self.class.default
  end
end
