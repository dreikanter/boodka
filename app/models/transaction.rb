# == Schema Information
#
# Table name: transactions
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     default(0), not null
#  currency     :string           not null
#  category_id  :integer
#  description  :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Transaction < ActiveRecord::Base
  include Currency

  monetize :amount_cents, with_model_currency: :currency

  validates :account_id, presence: true

  belongs_to :category
  belongs_to :account

  scope :with_account, -> { includes(:account) }
  scope :history, -> { with_account.order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }
end
