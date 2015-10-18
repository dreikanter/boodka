# == Schema Information
#
# Table name: reconciliations
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :reconciliation do
    account_ai 1
amount_cents 1
  end

end
