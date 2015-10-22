# == Schema Information
#
# Table name: budget_categories
#
#  id               :integer          not null, primary key
#  budget_id        :integer          not null
#  category_id      :integer          not null
#  planned_cents    :integer          default(0), not null
#  planned_currency :string           default("USD"), not null
#  memo             :string           default("0"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class BudgetCategory < ActiveRecord::Base
  validates :budget_id, :category_id, presence: true
  validates :planned, numericality: { greater_than: 0 }
  validates :planned_currency, inclusion: { in: Const::CURRENCY_CODES }

  monetize :planned_cents, with_model_currency: :amount_cents_currency

  belongs_to :budget

  delegate :year, :month, to: :budget
end
