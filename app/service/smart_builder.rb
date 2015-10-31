class SmartBuilder < ActionView::Helpers::FormBuilder
  def group(field)
    classes = ['form-group']
    classes << 'has-error' if errors(field).any?
    @template.content_tag(:div, class: classes.join(' ')) { yield }
  end

  def group_with_label(field)
    group(field) { label(field, class: 'control-label') + yield }
  end

  def group_with_error(field, options = {})
    group_with_label(field) { yield + field_errors(field) }
  end

  def text_input_group(field, options = {})
    group_with_error(field) do
      classes = ['form-control', options[:class]].join(' ')
      text_field(field, options.merge(class: classes))
    end
  end

  def text_area_group(field, options = {})
    group_with_error(field) do
      classes = ['form-control', options[:class]].join(' ')
      text_area(field, options.merge(class: classes))
    end
  end

  private

  def errors(field)
    @object.errors[field]
  end

  def field_errors(field)
    @template.content_tag(:span, errors(field).join(', '), class: 'help-block')
  end
end
