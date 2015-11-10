class TransferDecorator < Draper::Decorator
  delegate_all

  def row
    td = -> (opt) { h.content_tag(:td, opt[:content], class: opt[:classes]) }
    h.content_tag(:tr, cols.map(&td).join.html_safe, data: { href: edit_path })
  end

  private

  def cols
    [
      { content: display_time,          classes: 'col-lg-1 text-muted' },
      { content: account_title,         classes: 'col-lg-1' },
      { content: linked_amount,         classes: 'col-lg-1 text-right' },
      { content: amount_currency_label, classes: 'col-lg-1' },
      { content: description,           classes: 'col-lg-1' },
      { content: display_memo,          classes: 'col-lg-2' },
      { content: row_actions,           classes: 'col-lg-1' }
    ]
  end

  def edit_path
    h.edit_transaction_path(model)
  end
end

      # <table class="table table-hover">
      #   <% Transfer.recent_history.each do |transfer| %>
      #     <tr>
      #       <td class="col-lg-2 text-muted">
      #         <%= relative_time(transfer.created_at) %>
      #       </td>
      #       <td class="col-lg-10">
      #         <span class="text-muted">
      #           <%= "#{transfer.memo}" %>
      #         </span>
      #         <div class="table-row-actions">
      #           <%= link_to '<i class="fa fa-times"></i>'.html_safe, transfer, method: :delete, data: { confirm: 'Are you sure?' }, class: 'action-icon' %>
      #         </div>
      #       </td>
      #     </tr>
      #   <% end %>
      # </table>
