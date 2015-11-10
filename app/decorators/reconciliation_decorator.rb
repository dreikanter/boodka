# class ReconciliationDecorator < Draper::Decorator
#   delegate_all

#   def display_amount
#     model.amount.format(symbol: false, no_cents: false)
#   end

#   def currency_label
#     h.currency_label(model.amount.currency)
#   end

#   def display_time
#     h.relative_time(model.created_at)
#   end

#   def account_title
#     model.account.title
#   end

#   def linked_amount
#     classes = 'reconciliation'
#     h.link_to(display_amount, edit_path, class: classes)
#   end

#   def amount_currency_label
#     h.currency_label(model.amount.currency)
#   end

#   def row_actions
#     h.content_tag(:div, class: 'table-row-actions') do
#       h.link_to(
#         destroy_icon,
#         h.reconciliation_path(model.id),
#         method: :delete,
#         data: { confirm: 'Are you sure?' },
#         class: 'action-icon'
#       )
#     end
#   end

#   def destroy_icon
#     '<i class="fa fa-times"></i>'.html_safe
#   end

#   def row
#     td = -> (opt) { h.content_tag(:td, opt[:content], class: opt[:classes]) }
#     h.content_tag(:tr, cols.map(&td).join.html_safe, data: { href: edit_path })
#   end

#   private

#   def cols
#     [
#       {
#         content: display_time,
#         classes: 'col-lg-1 text-muted'
#       },
#       {
#         content: account_title,
#         classes: 'col-lg-1'
#       },
#       {
#         content: linked_amount,
#         classes: 'col-lg-1 text-right'
#       },
#       {
#         content: amount_currency_label,
#         classes: 'col-lg-1'
#       },
#       {
#         content: 'Reconciliation',
#         classes: 'col-lg-1'
#       },
#       {
#         content: '',
#         classes: 'col-lg-2'
#       },
#       {
#         content: row_actions,
#         classes: 'col-lg-1'
#       }
#     ]
#   end

#   def edit_path
#     h.edit_reconciliation_path(model)
#   end
# end
