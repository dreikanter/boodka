class OperationPresenter < BasicPresenter
  COLUMNS = {
    time:          'col-lg-1 op-time text-muted',
    account_title: 'col-lg-2 op-account',
    amount:        'col-lg-2 op-amount text-right',
    currency:      'col-lg-1 op-currency',
    details:       'col-lg-5 op-description',
    actions:       'col-lg-1 op-actions'
  }

  MANDATORY_COLUMNS = [
    :account_title,
    :amount,
    :currency,
    :actions,
    :href,
    :icon
  ]

  MANDATORY_COLUMNS.each { |m| alias_method(m, :not_implemented!)}

  def time
    h.relative_time(model.created_at)
  end

  def details
    [description, memo].reject(&:blank?).join(' &middot; ').html_safe
  end

  def description
    model.try(:description) || model.class.name
  end

  def memo
    return if model.try(:memo).blank?
    h.content_tag(:span, model.memo, class: 'text-muted')
  end

  def row
    h.content_tag(
      :tr, columns.join.html_safe,
      data: { href: href, remote: true },
      id: Selector.for_model(model),
      class: 'operation-row'
    )
  end

  private

  def columns
    COLUMNS.keys.map { |c| h.content_tag(:td, send(c), class: COLUMNS[c]) }
  end
end
