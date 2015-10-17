# == Schema Information
#
# Table name: rates
#
#  id         :integer          not null, primary key
#  ask        :float            not null
#  bid        :float            not null
#  rate       :float            not null
#  from       :string           not null
#  to         :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rate < ActiveRecord::Base
  validates :ask, :bid, :rate, :from, :to, presence: true
  validates :from, :to, inclusion: {
    in: Const::CURRENCY_CODES,
    message: 'Invalid currency code'
  }

  def self.fetch(from, to)
    currencies_ok = currency_is_supported?(from) && currency_is_supported?(to)
    fail 'Illegal currency code' unless currencies_ok
    Rate.where(from: from, to: to).last || fail('Rate is not available')
  end

  def self.currency_is_supported?(currency_code)
    Const::CURRENCY_CODES_SET.include?(currency_code)
  end

  def convert(amount)
    rate * amount
  end
end
