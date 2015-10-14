# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  currency   :string
#  amount     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
