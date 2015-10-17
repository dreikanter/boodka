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

class Transfer < ActiveRecord::Base
  validates :source_id, :destination_id, presence: true

  has_one :source, class_name: Transaction
  has_one :destination, class_name: Transaction
end
