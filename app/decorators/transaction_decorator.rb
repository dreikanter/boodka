class TransactionDecorator < Draper::Decorator
  delegate_all

  # TODO: Remove extra query
  def display_category
    classes = "transaction transaction-#{transaction_class}"
    h.content_tag :span, transaction_type, class: classes
  end

  def display_amount
    model.amount.format(symbol: false, no_cents: false)
  end

  def amount_currency_label
    h.currency_label(model.amount_currency)
  end

  def transaction_class
    return 'transfer' if model.transfer_id.present?
    model.inflow? ? 'income' : 'expense'
  end

  def transaction_type
    return 'Transfer' if model.transfer_id.present?
    model.inflow? ? 'Income' : model.category.try(:title)
  end

  def to_row
    h.content_tag(:tr) do
      h.content_tag(:td) do
        model.to_s
      end
    end
  end
end
