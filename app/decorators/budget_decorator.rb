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
end
