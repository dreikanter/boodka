# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  currency   :string
#  amount     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ActiveRecord::Base
  include AmountOfMoney

  has_many :transactions
  has_many :planned_transactions
end
