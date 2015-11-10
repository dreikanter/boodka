class ReconciliationPresenter < OperationPresenter
  DESTROY_ICON = '<i class="fa fa-times"></i>'.html_safe

  def time
    h.relative_time(model.created_at)
  end

  def account_title
    model.account.title
  end

  def amount
    model.amount.format(symbol: false, no_cents: false)
  end

  def currency
    h.currency_label(model.amount.currency)
  end

  def description
    'Reconciliation'
  end

  def memo
    ''
  end

  def actions
    h.content_tag(:div, class: 'table-row-actions') do
      h.link_to(
        DESTROY_ICON,
        h.reconciliation_path(model),
        method: :delete,
        data: { confirm: 'Are you sure?' },
        class: 'action-icon'
      )
    end
  end

  def href
    h.edit_reconciliation_path(model)
  end
end
