class TransferForm < Reform::Form
  property :memo

  property :amount, virtual: true
  property :currency, virtual: true
  property :from_account_id, virtual: true
  property :to_account_id, virtual: true
  property :created_at, virtual: true

  validates :amount, :currency, :from_account_id, :to_account_id, presence: true
  validates :amount, numericality: true
  validate :accounts_are_different

  private

  def accounts_are_different
    if from_account_id == to_account_id
      errors[:to_account_id] << 'destination account should be different'
    end
  end
end
