class AccountDecorator < Draper::Decorator
  delegate_all

  def display_title
    "#{model.title}#{' (default)' if model.default}"
  end
end
