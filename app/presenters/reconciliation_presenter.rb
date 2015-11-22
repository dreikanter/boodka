class ReconciliationPresenter < OperationPresenter
  DESTROY_ICON = '<i class="fa fa-times"></i>'.html_safe

  def icon
    'check'
  end

  def account_title
    model.account.title
  end

  def amount
    model.amount.format(symbol: false, no_cents: false)
  end

  DELTA_FORMAT = {
    symbol: false,
    no_cents: false,
    sign_before_symbol: true,
    sign_positive: true
  }

  def delta
    model.delta.format(DELTA_FORMAT)
  end

  def currency
    h.currency_label(model.amount.currency)
  end

  def description
    "Reconciliation: #{delta}"
  end

  def actions
    h.content_tag(:div, class: 'table-row-actions') do
      h.link_to(
        DESTROY_ICON,
        h.reconciliation_path(model, format: :js),
        method: :delete,
        remote: true,
        data: { confirm: 'Are you sure?' },
        class: 'action-icon'
      )
    end
  end

  def href
    h.edit_reconciliation_path(model, format: :js)
  end
end
