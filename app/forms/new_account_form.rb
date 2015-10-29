class NewAccountForm < BasicAccountForm
  include Composition

  model :account

  property :amount, on: :reconciliation
  property :reconciled_at, on: :reconciliation, from: :created_at

  validates :amount, numericality: true
end
