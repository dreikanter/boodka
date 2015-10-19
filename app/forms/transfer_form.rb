class TransferForm < FormObject
  attr_accessor :amount_currency,
                :amount,
                :from_account_id,
                :to_account_id,
                :description

  validates :from_account_id, :to_account_id, presence: true
  validates :amount, numericality: true
  validates :amount_currency, inclusion: { in: Const::CURRENCY_CODES }

  def self.permitted_params
    [
      :from_account_id,
      :to_account_id,
      :description,
      :amount,
      :amount_currency
    ]
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
      amount: -Float(amount),
      amount_currency: amount_currency,
      account_id: from_account_id
    }
  end

  def to_transaction_params
    {
      amount: Float(amount),
      amount_currency: amount_currency,
      account_id: to_account_id
    }
  end
end
