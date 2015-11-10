class TransferPresenter < OperationPresenter
  DESTROY_ICON = '<i class="fa fa-times"></i>'.html_safe

  def time
    h.relative_time(model.created_at)
  end

  def account_title
    model.transactions.map { |t| t.account.title }.join(' &rarr; ').html_safe
  end

  def amount
    transaction = model.transactions.first
    value = transaction.amount.format(symbol: false, no_cents: false)
    h.content_tag(:span, value, class: 'transfer')
  end

  def currency
    h.currency_label(model.transactions.first.amount_currency)
  end

  def description
    'Transfer'
  end

  def memo
    model.memo
  end

  def actions
    h.content_tag(:div, class: 'table-row-actions') do
      h.link_to(
        DESTROY_ICON,
        h.transfer_path(model),
        method: :delete,
        data: { confirm: 'Are you sure?' },
        class: 'action-icon'
      )
    end
  end

  def href
    h.edit_transfer_path(model)
  end
end
