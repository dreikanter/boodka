class OperationPresenter < BasicPresenter
  COLUMNS = {
    time_and_icon: 'col-lg-2 op-time text-muted',
    account_title: 'col-lg-2 op-account',
    amount:        'col-lg-2 op-amount text-right',
    currency:      'col-lg-1 op-currency',
    description:   'col-lg-2 op-description',
    memo:          'col-lg-2 op-memo',
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

  def time_and_icon
    classes = %Q(fa fa-#{icon} history-icon icon-#{model.class.name.downcase})
    h.content_tag(:i, '', class: classes) + time
  end

  def time
    h.relative_time(model.created_at)
  end

  def description
    model.try(:description) || model.class.name
  end

  def memo
    return unless model.try(:memo)
    h.content_tag(:span, model.memo, class: 'text-muted')
  end

  def row
    h.content_tag(
      :tr, columns.join.html_safe,
      data: { href: href },
      id: Selector.for_model(model)
    )
  end

  private

  def columns
    COLUMNS.keys.map { |c| h.content_tag(:td, send(c), class: COLUMNS[c]) }
  end
end
