class BudgetDecorator < Draper::Decorator
  delegate_all

  def amount_cell(options = {})
    h.cell(model, :amount, html: amount_cell_attributes(options))
  end

  def spent_cell
    h.readonly_cell(model, :spent, html: {
      class: :clickable,
      data: { href: spent_cell_href }
    })
  end

  def balance_cell
    h.readonly_cell(model, :balance, html: { class: 'highlight' })
  end

  private

  def amount_cell_attributes(options = {})
    {
      class: 'select-on-focus',
      data: {
        'year'   => model.year,
        'month'  => model.month,
        'cat-id' => model.category_id
      }
    }.merge(options)
  end

  def spent_cell_href
    h.operations_path(model.year, model.month,
      operation: :transaction, category_id: model.category_id)
  end
end
