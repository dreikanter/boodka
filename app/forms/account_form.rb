class AccountForm < FormObject
  def account_params
    {
      title: title,
      description: description,
      currency: currency
    }
  end

  def reconciliation_params
    {
      amount: amount,
      amount_date: amount_date
    }
  end

  def default?
    ['true', 't'].include? default.to_s.downcase
  end

  private

  def permitted_params
    [
      :title,
      :description,
      :id,
      :currency,
      :default,
      :amount,
      :amount_date
    ]
  end
end
