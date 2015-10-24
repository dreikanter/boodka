module PeriodHelper
  def period_nav_link(year, month, current_month)
    current = ([current_month, current_month + 1].include? month)
    button_class = current ? 'btn-primary' : 'btn-default'
    link_to(
      I18n.t("date.abbr_month_names")[month],
      period_path(year, month),
      class: "btn btn-sm month-button #{button_class}"
    )
  end

  MONTH_NUMS = 1..12

  def period_pagination(currenct_date)
    MONTH_NUMS.map do |month|
      period_nav_link(currenct_date.year, month, currenct_date.month)
    end.join.html_safe
  end

  def cell_id(prefix, period, category)
    [prefix, period.year, period.month, category.id].join('-')
  end
end
