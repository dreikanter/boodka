class TransactionPresenter < OperationPresenter
  DESTROY_ICON = '<i class="fa fa-times"></i>'.html_safe

  def icon
    model.outflow? ? 'arrow-circle-down' : 'arrow-circle-up'
  end

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
    classes = "transaction transaction-#{transaction_class}"
    h.content_tag :span, transaction_type, class: classes
  end

  def actions
    return '' if model.transfer?
    h.content_tag(:div, class: 'table-row-actions') do
      h.link_to(
        DESTROY_ICON,
        h.transaction_path(model),
        method: :delete,
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
    return 'transfer' if model.transfer_id.present?
    model.inflow? ? 'income' : 'expense'
  end

  def transaction_type
    return 'Transfer' if model.transfer_id.present?
    model.inflow? ? 'Income' : model.category.try(:title)
  end
end
