# == Schema Information
#
# Table name: transfers
#
#  id          :integer          not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :transfer do
    from_id 1
to_id 1
description "MyString"
  end

end
