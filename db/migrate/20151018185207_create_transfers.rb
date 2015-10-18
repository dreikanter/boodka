class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :from_transaction_id, null: false
      t.integer :to_transaction_id, null: false
      t.integer :from_account_id, null: false
      t.integer :to_account_id, null: false
      t.decimal :amount_cents, null: false, default: 0, precision: 8, scale: 0
      t.string :currency, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
