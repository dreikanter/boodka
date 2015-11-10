module OperationsHelper
  COLUMNS = [
    { content: :time,          classes: 'col-lg-1 text-muted' },
    { content: :account_title, classes: 'col-lg-1' },
    { content: :amount,        classes: 'col-lg-1 text-right' },
    { content: :currency,      classes: 'col-lg-1' },
    { content: :description,   classes: 'col-lg-1' },
    { content: :memo,          classes: 'col-lg-2' },
    { content: :actions,       classes: 'col-lg-1' }
  ]

  def row(operation)
    content = columns(operation).join.html_safe
    content_tag(:tr, content, data: { href: operation.href })
  end

  private

  def columns(operation)
    COLUMNS.map { |c| operation_call(operation.send[c[:content]], c[:classes]) }
  end

  def operation_call(content, classes)
    content_tag(:td, content, class: classes)
  end
end
