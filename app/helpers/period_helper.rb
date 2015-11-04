module PeriodHelper
  MONTH_NUMS = 1..12

  def period_pagination(selected_date)
    MONTH_NUMS.map do |month|
      period_nav_link(selected_date.year, month, selected_date.month)
    end.join.html_safe
  end

  private

  def selected_month?(selected_month, month)
    last_visible = selected_month + Const::PERIODS_PER_PAGE - 1
    (selected_month..last_visible).include?(month)
  end

  def current_month?(year, month)
    today = Date.today
    (today.year == year) && (today.month == month)
  end

  def period_nav_classes(year, month, selected_month)
    classes = %w(btn btn-sm month-button)
    selected = selected_month?(selected_month, month)
    classes << (selected ? 'btn-primary' : 'btn-default')
    classes << 'current' if current_month?(year, month)
    classes.join(' ')
  end

  def period_nav_link(year, month, selected_month)
    link_to(I18n.t("date.abbr_month_names")[month],
            period_path(year, month),
            class: period_nav_classes(year, month, selected_month))
  end
end
