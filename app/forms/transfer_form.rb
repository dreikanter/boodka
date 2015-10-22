class TransferForm < Reform::Form
  property :description

  property :amount, virtual: true
  property :currency, virtual: true
  property :from_account_id, virtual: true
  property :to_account_id, virtual: true

  validates :amount, :currency, :from_account_id, :to_account_id, presence: true
  validates :amount, numericality: true
end
