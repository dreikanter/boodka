after 'demo:accounts' do
  RECORDS = [
    {
      account_id: 1,
      amount_cents: 1000000
    },
    {
      account_id: 2,
      amount_cents: 500000000
    },
    {
      account_id: 3,
      amount_cents: 7000000
    },
    {
      account_id: 4,
      amount_cents: 1480000
    },
    {
      account_id: 5,
      amount_cents: 133700
    }
  ]

  RECORDS.each { |r| Reconciliation.create!(r) }
end
