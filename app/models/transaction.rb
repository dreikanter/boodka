# == Schema Information
#
# Table name: transactions
#
#  id             :integer          not null, primary key
#  account_id     :integer          not null
#  amount_cents   :integer          default(0), not null
#  currency       :string           not null
#  category_id    :integer
#  description    :string           default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reconsiliation :boolean          default(FALSE)
#

class Transaction < ActiveRecord::Base
  include Currency

  monetize :amount_cents, with_model_currency: :currency

  validates :account_id, presence: true
  validates :reconsiliation, inclusion: { in: [true, false] }

  belongs_to :category
  belongs_to :account

  TAIL_LENGTH = 20

  scope :payments, -> { where(reconsiliation: false) }
  scope :payments_history, -> { payments.order(created_at: :desc) }
  scope :recent_history, -> { payments_history.limit(TAIL_LENGTH) }
end
