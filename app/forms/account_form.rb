class AccountForm < FormObject
  attr_accessor :title,
                :default,
                :currency,
                :amount,
                :amount_date,
                :description

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

  def set_as_default?
    default == true
  end

  private

  def permitted_params
    [:title, :description, :id, :currency, :default]
  end
end
