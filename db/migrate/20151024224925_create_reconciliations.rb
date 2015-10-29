class CreateReconciliations < ActiveRecord::Migration
  def change
    create_table :reconciliations do |t|
      t.integer :account_id, null: false
      t.decimal :amount_cents, null: false, precision: 8, scale: 0, default: 0

      t.timestamps null: false
    end
  end
end
