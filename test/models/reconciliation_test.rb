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

require 'test_helper'

class ReconciliationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
