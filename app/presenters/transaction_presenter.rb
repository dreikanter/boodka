class TransactionPresenter < OperationPresenter
  DESTROY_ICON = '<i class="fa fa-times"></i>'.html_safe

  def account_title
    model.account.title
  end

  def amount
    classes = "transaction-#{model.direction}"
    value = model.amount.format(symbol: false, no_cents: false)
    h.content_tag(:span, value, class: classes)
  end

  def currency
    h.currency_label(model.amount_currency)
  end

  def description
    model.expense? ? "Exp: #{model.category.try(:title)}" : 'Income'
  end

  def actions
    return '' if model.transfer?
    h.content_tag(:div, class: 'table-row-actions') do
      h.link_to(
        DESTROY_ICON,
        h.transaction_path(model, format: :js),
        method: :delete,
        remote: true,
        data: { confirm: 'Are you sure?' },
        class: 'action-icon'
      )
    end
  end

  def href
    h.edit_transaction_path(model)
  end

  private

  def transaction_class
    return 'default' if model.transfer_id.present?
    model.inflow? ? 'success' : 'default'
  end

  def transaction_label_text
    return 'Transfer' if model.transfer_id.present?
    model.inflow? ? 'Income' : 'Expense'
  end
end
