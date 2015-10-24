class CreateBalanceUpdates < ActiveRecord::Migration
  def change
    create_table :balance_updates do |t|
      t.integer :account_id, null: false
      t.integer :amount_cents, null: false
      t.string :memo, null: false, default: ''

      t.timestamps null: false
    end
  end
end
