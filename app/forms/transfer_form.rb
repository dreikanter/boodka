class TransferForm < FormObject
  attr_accessor :amount,
                :amount_currency,
                :from_account_id,
                :to_account_id,
                :description

  CENTS_IN_UNIT = 100

  def initialize(request_params = nil)
    super process_params(request_params)
  end

  def transfer_params
    {
      description: description
    }
  end

  def from_transaction_params
    {
      amount: -Money.new(parsed_amount, amount_currency) * CENTS_IN_UNIT,
      account_id: from_account_id
    }
  end

  def to_transaction_params
    {
      amount: Money.new(parsed_amount, amount_currency) * CENTS_IN_UNIT,
      account_id: to_account_id
    }
  end

  private

  def permitted_params
    [
      :from_account_id,
      :to_account_id,
      :description,
      :amount,
      :amount_currency
    ]
  end

  def parsed_amount
    amount.to_f
  end

  def process_params(params)
    params ? params.require(:transfer_form).permit(permitted_params) : {}
  end
end
