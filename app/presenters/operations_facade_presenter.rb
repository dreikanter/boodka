class OperationsFacadePresenter < BasicPresenter
  def info
    Array.new.tap do |a|
      a << "Operation type: <b>#{type_names.titlecase}</b>" if model.filtered
      a << "Category: <b>#{model.category.title}</b>" if category
      a << "Showing all operations for selected period" unless model.filtered
    end.join('; ').html_safe + reset_filter_link
  end

  private

  def type_names
    model.types.map { |value| value.pluralize }.join(', ')
  end

  def reset_filter_link
    return '' unless model.filtered
    h.link_to('Reset filter', model.reset_filter_path, class: 'reset-filter')
  end
end
