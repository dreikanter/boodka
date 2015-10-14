# == Schema Information
#
# Table name: transactions
#
#  id           :integer          not null, primary key
#  account_id   :integer
#  amount_cents :integer
#  currency     :string
#  category_id  :integer
#  description  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Transaction < ActiveRecord::Base
  monetize :amount_cents, with_model_currency: :currency
end
