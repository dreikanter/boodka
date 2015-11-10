class OperationPresenter < BasicPresenter
  METHODS = %w(
    time
    account_title
    amount
    currency
    description
    memo
    actions
    href
  )

  METHODS.each { |m| alias_method(m.to_sym, :not_implemented!)}
end
