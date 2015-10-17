# == Schema Information
#
# Table name: rates
#
#  id         :integer          not null, primary key
#  rate       :float            not null
#  from       :string           not null
#  to         :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rate < ActiveRecord::Base
  validates :from, :to, :rate, presence: true
  validates :rate, numericality: { greater_than_or_equal_to: 0.0 }
  validates :from, :to, inclusion: {
    in: Const::ISO_CURRENCY_CODES,
    message: 'Invalid currency code'
  }
end
