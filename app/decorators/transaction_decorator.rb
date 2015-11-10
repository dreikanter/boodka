# class TransactionDecorator < Draper::Decorator
#   delegate_all

#   # TODO: Remove extra query
#   def display_category
#     classes = "transaction transaction-#{transaction_class}"
#     h.content_tag :span, transaction_type, class: classes
#   end

#   def display_amount
#     model.amount.format(symbol: false, no_cents: false)
#   end

#   def amount_currency_label
#     h.currency_label(model.amount_currency)
#   end

#   def transaction_class
#     return 'transfer' if model.transfer_id.present?
#     model.inflow? ? 'income' : 'expense'
#   end

#   def transaction_type
#     return 'Transfer' if model.transfer_id.present?
#     model.inflow? ? 'Income' : model.category.try(:title)
#   end

#   def linked_amount
#     classes = "transaction-#{model.direction}"
#     h.link_to(display_amount, edit_path, class: classes)
#   end

#   def display_time
#     h.relative_time(model.created_at)
#   end

#   def account_title
#     model.account.title
#   end

#   def row_actions
#     return '' if model.transfer?
#     h.content_tag(:div, class: 'table-row-actions') do
#       h.link_to(
#         destroy_icon,
#         h.transaction_path(model),
#         method: :delete,
#         data: { confirm: 'Are you sure?' },
#         class: 'action-icon'
#       )
#     end
#   end

#   def destroy_icon
#     '<i class="fa fa-times"></i>'.html_safe
#   end

#   def display_memo
#     h.content_tag(:span, model.memo, class: 'text-muted')
#   end

#   def description
#     display_category
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
#         content: description,
#         classes: 'col-lg-1'
#       },
#       {
#         content: display_memo,
#         classes: 'col-lg-2'
#       },
#       {
#         content: row_actions,
#         classes: 'col-lg-1'
#       }
#     ]
#   end

#   def edit_path
#     h.edit_transaction_path(model)
#   end
# end
