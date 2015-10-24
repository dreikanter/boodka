# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime         not null
#  year       :integer          not null
#  month      :integer          not null
#  memo       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NullPeriod < Period
  def self.starting_at(year, month)
    start_at = DateTime.new(year, month)
    new year: year,
        month: month,
        start_at: start_at,
        end_at: start_at + 1.month - 1.second
  end
end
