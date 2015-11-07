module PeriodHelper
  MONTH_NUMS = 1..12
  CURRENT_PERIOD_CLASS = 'active'

  def period_pagination(periods)
    first_period = periods.first
    MONTH_NUMS.map do |month|
      period_nav_link(first_period.year, month, first_period.month)
    end.join.html_safe
  end

  private

  def period_nav_link(year, month, first_month)
    link_to(I18n.t("date.abbr_month_names")[month],
            period_path(year, month),
            class: period_nav_classes(year, month, first_month))
  end

  def period_nav_classes(year, month, first_month)
    classes = %w(btn btn-sm month-button)
    classes << (displayed?(first_month, month) ? 'btn-primary' : 'btn-default')
    classes << CURRENT_PERIOD_CLASS if current_month?(year, month)
    classes.join(' ')
  end

  def displayed?(first_month, month)
    last_visible = first_month + Const::PERIODS_PER_PAGE - 1
    (first_month..last_visible).include?(month)
  end

  def today
    @today ||= Time.use_zone(Const::TZ) { Time.zone.now }
  end

  def current_month?(year, month)
    (today.year == year) && (today.month == month)
  end
end
