class PeriodDecorator < Draper::Decorator
  delegate_all

  def title
    Date.new(model.year, model.month).strftime('%B %Y')
  end

  # Navigation

  def link_to_prev_year
    return disabled_link_to_period('A.D.') if model.year < 2
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

  # Cells

  def total_uncategorized_expense_cell
    h.readonly_cell(model, :total_uncategorized_expense, highlight: :negative)
  end

  def total_income_cell
    h.readonly_cell(model, :total_income, highlight: :both)
  end

  def total_budgeted_cell
    h.readonly_cell(model, :total_budgeted)
  end

  def total_expense_cell
    h.readonly_cell(model, :total_expense, html: { class: 'clickable', data: {
      href: total_expense_cell_href,
      remote: false
    } })
  end

  def total_balance_cell
    h.readonly_cell(model, :total_balance, highlight: :both, html: {
      class: 'highlight'
    })
  end

  def available_to_budget_cell
    h.readonly_cell(model, :available_to_budget, highlight: :both, html: {
      class: 'highlight'
    })
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

  def total_expense_cell_href
    h.operations_path(model.year, model.month,
      operation: :transaction, direction: Const::OUTFLOW)
  end
end
