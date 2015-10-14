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

class Rate < ActiveRecord::Base
  validates :from, :to, :rate, present: true
  validates :from, :to, inclusion: {
    in: Const::ISO_CURRENCY_CODES,
    message: 'Invalid currency code'
  }

  validates :form, :to, length: { is: Const::ISO_CURRENCY_CODE_LENGTH }
  validates :rate, numericality: { greater_than_or_equal_to: 0.0 }
end
