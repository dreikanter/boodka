class AccountDecorator < Draper::Decorator
  delegate_all

  def display_title
    "#{model.title}#{' (default)' if model.default}"
  end

  def display_title_with_currency
    "#{model.title} (#{model.currency})#{' (default)' if model.default}"
  end
end
