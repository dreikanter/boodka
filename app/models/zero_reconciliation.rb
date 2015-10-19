class ZeroReconciliation < Reconciliation
  def initialize(account)
    created_at = account.transactions.first.created_at
    super(account: account, amount_cents: 0, created_at: created_at)
  end
end
