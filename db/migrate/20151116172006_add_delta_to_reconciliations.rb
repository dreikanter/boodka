class AddDeltaToReconciliations < ActiveRecord::Migration[4.2]
  def change
    add_column :reconciliations, :delta_cents, :integer, null: false, default: 0

    Reconciliation.all.each do |rec|
      total = Calc.total(account: rec.account, at: rec.created_at)
      rec.update!(delta_cents: rec.amount_cents - total.cents)
    end
  end
end
