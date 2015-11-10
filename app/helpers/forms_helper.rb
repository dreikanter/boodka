module FormsHelper
  def options_for_account_select(model, field)
    optionate = lambda do |account|
      [
        account.display_title_with_currency,
        account.id,
        { 'data-currency' => account.currency }
      ]
    end

    accounts = Account.ordered.decorate.map(&optionate)
    selected = model.persisted? ? model.send(field) : Account.default_id
    options_for_select(accounts, selected)
  end

  def button_to(title, path, options = {})
    enabled = options[:enabled].present? ? options[:enabled] : true
    classes = %w(btn btn-default)
    classes << 'disabled' unless enabled
    link_to(title, path, class: classes.join(' '))
  end
end
