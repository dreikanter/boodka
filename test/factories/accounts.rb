# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  currency    :string           not null
#  title       :string           not null
#  description :string           default(""), not null
#  default     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :account, class: Account do
    title "Sample Account"
    description "A description for the account"
    currency "USD"
    default false
    created_at 24.hours.ago
    updated_at 12.hours.ago
  end

  factory :default_account, class: Account do
    title "Default Account"
    description "A description for the account"
    currency "USD"
    default true
    created_at 24.hours.ago
    updated_at 12.hours.ago
  end
end
