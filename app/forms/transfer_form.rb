class TransferForm < FormObject
  attr_accessor :amount,
                :amount_currency,
                :from_account_id,
                :to_account_id,
                :description

  CENTS_IN_UNIT = 100

  def transfer_params
    {
      description: description
    }
  end

  def from_transaction_params
    {
      amount: -processed_amount,
      account_id: from_account_id
    }
  end

  def to_transaction_params
    {
      amount: processed_amount,
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

  def currency
    amount_currency.blank? ? nil : Money::Currency.new(amount_currency)
  end

  def subunit_to_unit
    currency ? currency.subunit_to_unit : 0
  end

  def processed_amount
    Money.new(amount.to_f, currency) * subunit_to_unit
  end
end
