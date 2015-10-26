FactoryGirl.define do
  factory :sample_amount_of_money, class: Money do
    initialize_with { Money.new(10000, ENV['base_currency']) }
  end
end
