# == Schema Information
#
# Table name: transactions
#
#  id                         :integer          not null, primary key
#  account_id                 :integer          not null
#  direction                  :integer          default(0), not null
#  amount_cents               :integer          default(0), not null
#  amount_currency            :string           default("USD"), not null
#  calculated_amount_cents    :integer          default(0), not null
#  calculated_amount_currency :string           default("USD"), not null
#  rate                       :float            default(1.0), not null
#  kind                       :integer          default(0), not null
#  category_id                :integer
#  memo                       :string           default(""), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

FactoryGirl.define do
  factory :inflow_transaction, class: Transaction do
    amount_cents 10000
    direction Const::INFLOW
  end

  factory :outflow_transaction, parent: :inflow_transaction do
    direction Const::OUTFLOW
  end
end
