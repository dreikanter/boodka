# == Schema Information
#
# Table name: transactions
#
#  id                         :integer          not null, primary key
#  account_id                 :integer          not null
#  amount_cents               :integer          default(0), not null
#  amount_currency            :string           default("USD"), not null
#  calculated_amount_cents    :integer          default(0), not null
#  calculated_amount_currency :string           default("USD"), not null
#  rate                       :float            default(1.0), not null
#  category_id                :integer
#  transfer_id                :integer
#  description                :string           default(""), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
