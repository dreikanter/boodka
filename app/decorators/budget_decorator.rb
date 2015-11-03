class BudgetDecorator < Draper::Decorator
  delegate_all

  def display_amount
    model.amount.format(symbol: false, no_cents: true)
  end

  def display_spent
    model.spent.format(symbol: false, no_cents: true)
  end

  def display_balance
    model.balance.format(symbol: false, no_cents: true)
  end

  def amount_cell(options = {})
    h.cell(model, :amount, html: amount_cell_attributes(options))
  end

  def spent_cell
    h.readonly_cell(model, :spent)
  end

  def balance_cell
    h.readonly_cell(model, :balance, highlight: :both)
  end

  private

  def amount_cell_attributes(options = {})
    {
      class: 'select-on-focus',
      data: {
        "year"             => model.year,
        "month"            => model.month,
        "cat-id"           => model.category_id,
        "plain-amount"     => model.amount.to_i,
        "formatted-amount" => display_amount
      }
    }.merge(options)
  end
end
