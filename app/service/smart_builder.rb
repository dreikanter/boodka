class SmartBuilder < ActionView::Helpers::FormBuilder
  def text(field, options = {})
    group_for(field) do
      classes = ['form-control', options[:class]].join(' ')
      text_field(field, options.merge(class: classes))
    end
  end

  def area(field, options = {})
    group_for(field) do
      classes = ['form-control', options[:class]].join(' ')
      text_area(field, options.merge(class: classes))
    end
  end

  def submit_group(options = {})
    group do
      submit(options[:caption], class: 'btn btn-success submit-button',
        data: { disable_with: 'Processing...' }) + ' ' +
        (options[:cancel] ? cancel_button : '')
    end
  end

  def check(field, label, options = {})
    @template.content_tag(:div, class: 'checkbox') do
      @template.content_tag(:label) do
        check_box(field, {}, 'true', 'false') + " #{label}"
      end
    end
  end

  def select(field, options = {})
    group_for(field) do
      super(
        field,
        options[:options], {},
        data: { width: '100%' },
        class: "select select-#{field.to_s.gsub('_', '-')}"
      )
    end
  end

  def datetime(field, options = {})
    group_for(field) do
      value = object.send(field).try(:strftime, Const::DATEPICKER_FORMAT_PARSE)
      classes = ['form-control date-time-picker', options[:class]].join(' ')
      text_field field, value: value, class: classes
    end
  end

  def static(field, value = nil)
    value = value || object.send(field)
    group_for(field) do
      @template.content_tag(:p, value, class: 'form-control-static')
    end
  end

  def radio_buttons(field, options = {})
    group do
      @template.content_tag(:div, class: 'btn-group', data: { toggle: 'buttons' }) do
        radio_items(field, options[:options], object.send(field)).inject(:+)
      end
    end
  end

  private

  def group(field = nil)
    classes = ['form-group']
    classes << 'has-error' if (field && errors(field).any?)
    @template.content_tag(:div, class: classes.join(' ')) { yield }
  end

  def labeled_group(field)
    group(field) { label(field, class: 'control-label') + yield }
  end

  def group_for(field)
    labeled_group(field) { yield + field_errors(field) }
  end

  def errors(field)
    @object.errors[field]
  end

  def field_errors(field)
    @template.content_tag(:span, errors(field).join(', '), class: 'help-block')
  end

  def cancel_button
    @template.link_to('Cancel', :back, class: 'btn btn-default')
  end

  def radio_items(field, options, checked)
    options.map { |k, v| radio_item(field, k, v, checked == k) }
  end

  def radio_item(field, value, caption, checked)
    label(field, class: "btn btn-default #{' active' if checked}") do
      classes = "radio-#{field} radio-option-#{value}"
      radio_button(field, value, checked: checked,
        autocomplete: 'off', class: classes) + " #{caption}"
    end
  end
end
