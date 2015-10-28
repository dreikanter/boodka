class CreateReconciliations < ActiveRecord::Migration
  def change
    create_table :reconciliations do |t|
      t.integer :account_id, null: false
      t.monetize :amount, null: false, default: 0

      t.timestamps null: false
    end
  end
end
