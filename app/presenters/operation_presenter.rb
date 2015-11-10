class OperationPresenter < BasicPresenter
  COLUMNS = {
    time:          'col-lg-1 text-muted',
    account_title: 'col-lg-1',
    amount:        'col-lg-1 text-right',
    currency:      'col-lg-1',
    description:   'col-lg-1',
    memo:          'col-lg-2',
    actions:       'col-lg-1'
  }

  COLUMNS.keys.each { |m| alias_method(m, :not_implemented!)}

  alias_method :href, :not_implemented!

  def row
    h.content_tag(:tr, columns.join.html_safe, data: { href: href })
  end

  private

  def columns
    COLUMNS.keys.map { |c| h.content_tag(:td, send(c), class: COLUMNS[c]) }
  end
end
