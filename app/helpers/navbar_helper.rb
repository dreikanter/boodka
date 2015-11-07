module NavbarHelper
  def navbar(options = {})
    content_tag(:ul, class: navbar_classes(options)) { yield }
  end

  def navbar_item(options = {})
    content_tag(:li, class: navbar_item_classes(options)) do
      link_to(options[:caption], options[:path], target: options[:target])
    end
  end

  def navbar_dropdown(options)
    link = dropdown_link(options[:caption])
    menu = content_tag(:ul, class: 'dropdown-menu') { yield }
    content_tag(:li, class: 'dropdown') { link + menu }
  end

  private

  def navbar_classes(options)
    classes = %w(nav navbar-nav navbar-menu)
    classes += %w(navbar-right) if options[:side] == :right
    classes.join(' ')
  end

  def navbar_item_classes(options)
    classes = %w()
    classes += %w(active) if current_page?(options[:path])
    classes.join(' ')
  end

  def dropdown_link(caption)
    caption = %Q(#{caption} <span class="caret"></span>).html_safe
    link_to(caption, '#', DROPDOWN_LINK_ATTRS)
  end

  DROPDOWN_LINK_ATTRS = {
    'class' => 'dropdown-toggle',
    'data' => { 'toggle' => 'dropdown' },
    'role' => 'button',
    'aria-haspopup' => 'true',
    'aria-expanded' => 'false'
  }
end
