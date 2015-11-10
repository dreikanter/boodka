# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  memo            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#  from_account_id :integer
#  to_account_id   :integer
#

class Transfer < ActiveRecord::Base
  has_many :transactions, dependent: :destroy

  scope :history, -> { order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }
end
