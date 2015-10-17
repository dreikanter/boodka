# == Schema Information
#
# Table name: transfers
#
#  id             :integer          not null, primary key
#  source_id      :integer          not null
#  destination_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :transfer do
    
  end

end
