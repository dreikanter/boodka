RECORDS = [
  {
    title: 'Bills'
  },
  {
    title: 'Enterntainment'
  },
  {
    title: 'Groceries'
  },
  {
    title: 'Healthcare'
  },
  {
    title: 'Household'
  },
  {
    title: 'Phone & ISP'
  },
  {
    title: 'Spendings'
  },
  {
    title: 'Transportation'
  }
]

RECORDS.each { |r| Category.create!(r) }
