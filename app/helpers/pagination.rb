class Pagination
  MONTH_NUMS = 1..12
  BTN_CLASSES = 'btn btn-sm btn-default'
  ONE_MONTH = 1
  RARR = '&rarr;'.html_safe
  LARR = '&larr;'.html_safe

  attr_reader :year, :month, :base_path, :period_length

  def initialize(view, year, month, base_path, period_length = nil)
    @view = view
    @year, @month = sanitize_year_and_moth(year, month)
    @base_path = base_path
    @period_length = period_length || ONE_MONTH
  end

  def link_to_next_year
    link(year + 1, month, "#{year + 1} &rarr;".html_safe)
  end

  def link_to_previous_year
    return disabled_link('A.D.') if year < 2
    link(year - 1, month, "&larr; #{year - 1}".html_safe)
  end

  def pagination_bar
    month_links = MONTH_NUMS.map { |m| page_link(m) }
    month_links.unshift(link_to_prev).push(link_to_next).join.html_safe
  end

  private

  def sanitize_year_and_moth(year, month)
    today = Time.current
    year = Integer(year || today.year)
    month = Integer(month || today.month)
    [year, month]
  end

  def selected_date
    @current_page_date ||= DateTime.new(year, month)
  end

  def link(year, month, text)
    h.link_to(text, path(year, month), class: BTN_CLASSES)
  end

  def disabled_link(text)
    h.link_to(text, '#', class: "#{BTN_CLASSES} disabled")
  end

  def page_link(month)
    caption = I18n.t("date.abbr_month_names")[month]
    h.link_to(caption, path(year, month), class: link_classes(year, month))
  end

  def link_classes(year, month)
    classes = %w(btn btn-sm)
    classes << 'active' if current?(year, month)
    classes << (selected?(year, month) ? 'btn-primary' : 'btn-default')
    classes.join(' ')
  end

  def link_to_next
    date = selected_date + 1.month
    link(date.year, date.month, RARR)
  end

  def link_to_prev
    date = selected_date - 1.month
    link(date.year, date.month, LARR)
  end

  def current_time
    @current_time ||= Time.current
  end

  def current?(year, month)
    (current_time.year == year) && (current_time.month == month)
  end

  def selected?(year, month)
    months = self.month..(self.month + period_length - 1)
    (self.year == year) && months.include?(month)
  end

  def path(year, month)
    h.send(base_path, year: year, month: month)
  end

  def h
    @view
  end
end
