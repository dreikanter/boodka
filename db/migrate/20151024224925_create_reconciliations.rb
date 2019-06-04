class CreateReconciliations < ActiveRecord::Migration[4.2]
  def change
    create_table :reconciliations do |t|
      t.integer :account_id, null: false
      t.integer :amount_cents, null: false, default: 0

      t.timestamps null: false
    end
  end
end
