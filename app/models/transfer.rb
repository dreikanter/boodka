class Transfer < ActiveRecord::Base
  validates :source_id, :destination_id, presence: true

  has_one :source, class_name: Transaction
  has_one :destination, class_name: Transaction
end
