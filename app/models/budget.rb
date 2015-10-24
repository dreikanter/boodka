# == Schema Information
#
# Table name: budgets
#
#  id               :integer          not null, primary key
#  period_id        :integer          not null
#  category_id      :integer          not null
#  planned_cents    :integer          default(0), not null
#  planned_currency :string           default("USD"), not null
#  memo             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Budget < ActiveRecord::Base
  validates :period_id, :category_id, presence: true
  validates :planned, numericality: { greater_than: 0 }
  validates :planned_currency, inclusion: { in: Const::CURRENCY_CODES }

  monetize :planned_cents, with_model_currency: :amount_cents_currency

  belongs_to :period
  belongs_to :category

  delegate :year, :month, to: :period
end
