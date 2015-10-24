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
end
