# == Schema Information
#
# Table name: transfers
#
#  id                  :integer          not null, primary key
#  from_transaction_id :integer          not null
#  to_transaction_id   :integer          not null
#  from_account_id     :integer          not null
#  to_account_id       :integer          not null
#  amount_cents        :decimal(8, )     default(0), not null
#  currency            :string           not null
#  description         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :transfer do
    from_id 1
to_id 1
description "MyString"
  end

end
