RECORDS = [
  {
    currency: 'USD',
    title: 'Raiffeisen',
    memo: '',
    default: true
  },
  {
    currency: 'EUR',
    title: 'City',
    memo: '',
    default: false
  },
  {
    currency: 'RUB',
    title: 'Tinkoff',
    memo: '',
    default: false
  },
  {
    currency: 'RUB',
    title: 'Cash',
    memo: '',
    default: false
  },
  {
    currency: 'USD',
    title: 'Cash USD',
    memo: '',
    default: false
  }
]

RECORDS.each { |r| Account.create!(r) }
