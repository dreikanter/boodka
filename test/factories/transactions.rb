FactoryGirl.define do
  factory :inflow_transaction, class: Transaction do
    amount_cents 10000
    direction Const::INFLOW
  end

  factory :outflow_transaction, parent: :inflow_transaction do
    direction Const::OUTFLOW
  end
end
