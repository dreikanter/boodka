# == Schema Information
#
# Table name: planned_transactions
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :integer          default(0), not null
#  currency     :string           not null
#  category_id  :integer
#  description  :string           default(""), not null
#  start        :datetime
#  finish       :datetime
#  cron         :string           default(""), not null
#  enabled      :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class PlannedTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
