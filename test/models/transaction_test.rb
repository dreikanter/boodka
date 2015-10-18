# == Schema Information
#
# Table name: transactions
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     default(0), not null
#  currency     :string           not null
#  category_id  :integer
#  description  :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
