class PeriodDecorator < Draper::Decorator
  delegate_all

  def title
    Date.new(model.year, model.month).strftime('%B %Y')
  end

  def link_to_prev_year
    return disabled_link_to_period('A.D.', '#') if model.year < 2
    text = "&larr; #{model.year - 1}".html_safe
    link_to_period(model.year - 1, model.month, text)
  end

  def link_to_next_year
    text = "#{model.year + 1} &rarr;".html_safe
    link_to_period(model.year + 1, model.month, text)
  end

  def link_to_prev_month
    link_to_offset(-1, '&larr;')
  end

  def link_to_next_month
    link_to_offset(1, '&rarr;')
  end

  def total_uncategorized_expense_value
    value = Calc.total_uncategorized_expense(period: model)
    h.money_value(value, highlight: :negative, no_cents: true)
  end

  def total_income_value
    value = Calc.total_income(period: model)
    h.money_value(value, highlight: :both, no_cents: true)
  end

  def total_budgeted_value
    h.money_value(Calc.total_budgeted(period: model), no_cents: true)
  end

  def total_expense_value
    h.money_value(Calc.total_expense(period: model), no_cents: true)
  end

  def total_balance_value
    value = Calc.total_balance(period: model)
    h.money_value(value, highlight: :both, no_cents: true)
  end

  def available_to_budget
    value = Calc.available_to_budget(period: model)
    h.money_value(value, highlight: :both, no_cents: true, symbol: true)
  end

  private

  def link_to_period(year, month, text)
    h.link_to(text, h.period_path(year, month), class: 'btn btn-sm btn-default')
  end

  def disabled_link_to_period(text)
    h.link_to(text, '#', class: 'btn btn-sm btn-default disabled')
  end

  def link_to_offset(offset, text)
    date = DateTime.new(model.year, model.month) + offset.month
    link_to_period(date.year, date.month, text.html_safe)
  end
end
