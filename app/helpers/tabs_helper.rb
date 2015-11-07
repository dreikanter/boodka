module TabsHelper
  def tabs_group(options = {})
    classes = %w(nav nav-tabs) + [options[:class]]
    content_tag(:ul, class: classes.join(' ')) { yield }
  end

  def tab_item(options = {})
    content_tag(:li, role: :presentation, class: tab_item_classes(options)) do
      link_to(options[:caption], options[:path])
    end
  end

  private

  def tab_item_classes(options)
    'active' if current_page?(options[:path])
  end
end
