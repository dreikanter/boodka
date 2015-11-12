module PaginationHelper
  def link_to_previous_year(year, month, base_path)
    ledger_pager(year, month, base_path).link_to_previous_year
  end

  def pagination_bar(year, month, base_path)
    ledger_pager(year, month, base_path).pagination_bar
  end

  def link_to_next_year(year, month, base_path)
    ledger_pager(year, month, base_path).link_to_next_year
  end

  private

  def ledger_pager(year, month, base_path)
    @ledger_pager ||= Pagination.new(self, year, month, base_path)
  end
end
