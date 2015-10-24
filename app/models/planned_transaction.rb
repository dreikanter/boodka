# == Schema Information
#
# Table name: planned_transactions
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     not null
#  currency     :string           not null
#  category_id  :integer
#  memo         :string           default(""), not null
#  start        :datetime
#  finish       :datetime
#  cron         :string           default(""), not null
#  enabled      :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PlannedTransaction < ActiveRecord::Base
  monetize :amount_cents, with_model_currency: :currency
  validates :amount_currency,
            :calculated_amount_currency,
            inclusion: { in: Const::CURRENCY_CODES }

  validates :account_id, :amount_cents, :cron, :enabled, presence: true

  belongs_to :category
  belongs_to :account
end
