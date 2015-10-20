FactoryGirl.define do
  factory :sample_amount_of_money do
    initialize_with { Money.new(10000, SAMPLE_CURRENCY) }
  end
end
