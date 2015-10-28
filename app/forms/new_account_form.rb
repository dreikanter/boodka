class NewAccountForm < BasicAccountForm
  include Composition

  model :account

  property :amount, on: :transaction
  property :reconciled_at, on: :transaction, from: :created_at

  validates :amount, numericality: true
end
