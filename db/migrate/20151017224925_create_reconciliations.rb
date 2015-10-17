class CreateReconciliations < ActiveRecord::Migration
  def change
    create_table :reconciliations do |t|
      t.integer :account_id
      t.integer :amount_cents

      t.timestamps null: false
    end
  end
end
