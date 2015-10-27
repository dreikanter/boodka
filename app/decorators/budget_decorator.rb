class BudgetDecorator < Draper::Decorator
  delegate_all

  def display_amount
    model.amount.format(symbol: false)
  end

  def display_actual
    model.actual.format(symbol: false)
  end

  def display_balance
    model.balance.format(symbol: false)
  end

  def actual_cell
    h.money_cell(model.actual)
  end

  def balance_cell
    h.money_cell(model.balance, highlight: :both)
  end
end
