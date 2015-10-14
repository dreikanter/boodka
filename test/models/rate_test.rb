# == Schema Information
#
# Table name: rates
#
#  id         :integer          not null, primary key
#  rate       :float
#  from       :string
#  to         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
