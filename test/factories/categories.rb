# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  memo       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :category, class: Category do
    title { 'Groceries' }
    memo { 'A sample budgeting category' }
  end
end
