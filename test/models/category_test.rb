# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  code        :string           default(""), not null
#  title       :string           not null
#  description :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
