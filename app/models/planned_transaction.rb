# == Schema Information
#
# Table name: planned_transactions
#
#  id           :integer          not null, primary key
#  account_id   :integer
#  amount_cents :integer
#  currency     :string
#  category_id  :integer
#  description  :string
#  start        :datetime
#  finish       :datetime
#  cron         :string
#  enabled      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PlannedTransaction < ActiveRecord::Base
  include Currency
  monetize :amount_cents, with_model_currency: :currency

  belongs_to :category
  belongs_to :account
end
