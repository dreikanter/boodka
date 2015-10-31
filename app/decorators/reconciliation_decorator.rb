class ReconciliationDecorator < Draper::Decorator
  delegate_all

  def display_amount
    model.amount.format(symbol: false, no_cents: false)
  end

  def account_currency_label
    h.currency_label(model.amount.currency)
  end
end
