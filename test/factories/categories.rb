FactoryGirl.define do
  factory :valid_category, class: Category do
    title 'Groceries'
    memo 'A sample budgeting category'
  end
end
