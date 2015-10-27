class TransactionDecorator < Draper::Decorator
  delegate_all

  def display_category
    return model.category.try(:title) if model.outflow?
    h.content_tag :span, 'Income', class: 'positive'
  end
end
