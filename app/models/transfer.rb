# == Schema Information
#
# Table name: transfers
#
#  id         :integer          not null, primary key
#  memo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Transfer < ActiveRecord::Base
  has_many :transactions, dependent: :destroy

  scope :history, -> { order(created_at: :desc) }
  scope :recent_history, -> { history.limit(Const::RECENT_HISTORY_LENGTH) }
end
