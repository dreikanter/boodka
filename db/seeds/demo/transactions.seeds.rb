after 'demo:accounts' do
  RECORDS = [
    {
      account_id: 1,
      direction: 'outflow',
      amount_cents: 12313,
      amount_currency: 'USD',
      category_id: 1,
      memo: 'Sample transaction'
    },
    {
      account_id: 1,
      direction: 'outflow',
      amount_cents: 1000,
      amount_currency: 'RUB',
      category_id: 2,
      memo: 'Sample transaction'
    },
    {
      account_id: 2,
      direction: 'outflow',
      amount_cents: 4512,
      amount_currency: 'EUR',
      category_id: 1,
      memo: 'Sample transaction'
    },
    {
      account_id: 1,
      direction: 'outflow',
      amount_cents: 87786,
      amount_currency: 'USD',
      category_id: 4,
      memo: 'Sample transaction'
    },
    {
      account_id: 3,
      direction: 'outflow',
      amount_cents: 8790,
      amount_currency: 'RUB',
      category_id: 3,
      memo: 'Sample transaction'
    },
    {
      account_id: 1,
      direction: 'outflow',
      amount_cents: 1200,
      amount_currency: 'EUR',
      category_id: 7,
      memo: 'Sample transaction'
    },
    {
      account_id: 4,
      direction: 'outflow',
      amount_cents: 2134,
      amount_currency: 'USD',
      category_id: 1,
      memo: 'Sample transaction'
    }
  ]

  RECORDS.each { |r| Transaction.create!(r) }
end
