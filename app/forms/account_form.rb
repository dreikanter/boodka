class AccountForm < FormObject
  def account_params
    pick(:title, :description, :currency, :default)
  end

  def reconciliation_params
    pick(:amount, :created_at)
  end

  def permitted_params
    [
      :title,
      :description,
      :id,
      :currency,
      :default,
      :amount,
      :created_at
    ]
  end

  def default?
    ['true', 't'].include? default.to_s.downcase
  end

  def processed_default
    default?
  end

  def processed_amount
    Float(amount)
  rescue
    0.0
  end
end
