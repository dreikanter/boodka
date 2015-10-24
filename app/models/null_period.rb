class NullPeriod < Period
  def self.starting_at(year, month)
    start_at = DateTime.new(year, month)
    new year: year,
        month: month,
        start_at: start_at,
        end_at: start_at + 1.month - 1.second
  end
end
