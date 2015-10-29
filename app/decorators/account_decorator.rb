class AccountDecorator < Draper::Decorator
  delegate_all

  def display_title
    "#{model.title}#{' (default)' if model.default}"
  end

  def display_title_with_currency
    "#{model.title} (#{model.currency})#{' (default)' if model.default}"
  end

  def display_total(symbol = false)
    Calc.account_total(account: model).format(symbol: symbol, no_cents: true)
  end

  def display_total_with_symbol
    display_total(true)
  end

  def currency_label
    h.currency_label(model.currency)
  end
end
