# == Schema Information
#
# Table name: reconciliations
#
#  id           :integer          not null, primary key
#  account_id   :integer          not null
#  amount_cents :decimal(8, )     default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ZeroReconciliation < Reconciliation
  def initialize(account)
    super(account: account, amount_cents: 0, created_at: account.created_at)
  end
end
