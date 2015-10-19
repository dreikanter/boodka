class TransferForm < FormObject
  include Currency

  attr_accessor :currency,
                :amount,
                :from_account_id,
                :to_account_id,
                :description

  validates :from_account_id, :to_account_id, presence: true
  validates :amount, numericality: true

  def self.permitted_params
    [:from_account_id, :to_account_id, :description, :amount, :currency]
  end

  def self.from_params(params)
    new params.require(:transfer_form).permit(permitted_params)
  end

  def transfer_params
    {
      description: description
    }
  end

  def from_transaction_params
    {
      currency: currency,
      amount: Float(amount) * -1,
      account_id: from_account_id
    }
  end

  def to_transaction_params
    {
      currency: currency,
      amount: Float(amount),
      account_id: to_account_id
    }
  end
end
