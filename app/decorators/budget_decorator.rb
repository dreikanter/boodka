class BudgetDecorator < Draper::Decorator
  delegate_all

  def display_amount
    model.amount.format(symbol: false, no_cents: true)
  end

  def display_actual
    model.actual.format(symbol: false, no_cents: true)
  end

  def display_balance
    model.balance.format(symbol: false, no_cents: true)
  end

  def spent_cell
    h.money_cell(model.spent, no_cents: true)
  end

  def balance_cell
    h.money_cell(model.balance, highlight: :both, no_cents: true)
  end
end
