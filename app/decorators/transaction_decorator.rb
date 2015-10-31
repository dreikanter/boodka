class TransactionDecorator < Draper::Decorator
  delegate_all

  # TODO: Remove extra query
  def display_category
    return model.category.try(:title) if model.expense?
    classes = "kind kind-#{model.kind}"
    h.content_tag :span, model.kind.to_s.capitalize, class: classes
  end

  def display_amount
    model.amount.format(symbol: false, no_cents: false)
  end

  def amount_currency_label
    h.currency_label(model.amount_currency)
  end
end
