# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  currency   :string           not null
#  title      :string           not null
#  memo       :string           default(""), not null
#  default    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :account, class: Account do
    title 'Sample Account'
    memo 'A description for the account'
    currency 'USD'
    default false
    created_at 24.hours.ago
    updated_at 12.hours.ago
  end

  factory :default_account, class: Account do
    title 'Default Account'
    memo 'A description for the account'
    currency 'USD'
    default true
    created_at 24.hours.ago
    updated_at 12.hours.ago
  end

  factory :usd_account, parent: :account do
    currency 'USD'
  end

  factory :eur_account, parent: :account do
    currency 'EUR'
  end

  factory :rub_account, parent: :account do
    currency 'RUB'
  end
end
