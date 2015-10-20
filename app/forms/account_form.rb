class AccountForm < Reform::Form
  include Composition

  model :account

  property :title, on: :account
  property :description, on: :account
  property :id, on: :account
  property :currency, on: :account
  property :default, on: :account

  property :amount, on: :reconciliation
  property :reconciled_at, on: :reconciliation, from: :created_at
end
