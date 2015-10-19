class ZeroReconciliation < Reconciliation
  def initialize(account)
    super(account: account, amount_cents: 0, created_at: account.created_at)
  end
end
