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
    group { submit_button(options) }
  end

  def submit_button(options = {})
    submit(options[:caption], class: 'btn btn-success submit-button',
      data: { disable_with: 'Processing...' }) + ' ' +
      cancel_button(options[:cancel])
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

  def account_select(field)
    select(field, options: options_for_account_select(field))
  end

  def currency_select(field)
    select(field, options: options_for_currency_select(field))
  end

  def datetime(field, options = {})
    group_for(field) do
      value = object.send(field).try(:strftime, Const::DATEPICKER_FORMAT_PARSE)
      classes = ['form-control date-time-picker', options[:class]].join(' ')
      text_field(field, **options.merge(value: value, class: classes))
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
        radio_items(field, options[:options], object.send(field))
      end
    end
  end

  def amount_input
    labeled_group(:amount) do
      @template.content_tag(:div, class: 'row') do
        @template.content_tag(:div, class: 'col-lg-6 col-md-8 col-sm-8 col-xs-8') do
          classes = "form-control select-on-focus input-amount"
          text_field(:amount, placeholder: 'Amount', class: classes, data: { direction: '' })
        end +
        @template.content_tag(:div, class: 'col-lg-6 col-md-4 col-sm-4 col-xs-4 text-right') do
          radio_buttons(:direction, options: { inflow: 'Income', outflow: 'Expense' })
        end
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

  def cancel_button(cancel)
    return '' unless cancel
    @template.link_to('Cancel', cancel, class: 'btn btn-default')
  end

  def radio_items(field, options, checked_value)
    options.map { |k, v| radio_item(field, k, v, checked_value) }.inject(:+)
  end

  def radio_item(field, value, caption, checked_value)
    checked = (checked_value.to_s == value.to_s)
    label(field, class: "btn btn-default #{' active' if checked}") do
      classes = "radio-#{field} radio-option-#{value}"
      radio_button(field, value, checked: checked,
        autocomplete: 'off', class: classes) + " #{caption}"
    end
  end

  # TODO: Cache Account#default_id

  def options_for_account_select(field)
    optionate = lambda do |account|
      [
        account.display_title_with_currency,
        account.id,
        { 'data-currency' => account.currency }
      ]
    end

    accounts = Account.ordered.decorate.map(&optionate)
    selected = @object.send(field)
    @template.options_for_select(accounts, selected)
  end

  def options_for_currency_select(field)
    selected = @object.send(field)
    @template.options_for_select(Const::CURRENCY_CODES, selected)
  end
end
