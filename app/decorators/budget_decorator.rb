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
      tabindex: options[:tabindex],
      data: {
        "year"             => model.year,
        "month"            => model.month,
        "cat-id"           => model.category_id,
        # "spent"            => cell_id('spent', period, category),
        # "balance"          => cell_id('balance', period, category),
        "plain-amount"     => model.amount.to_i,
        "formatted-amount" => display_amount
      }
    }
  end
end
