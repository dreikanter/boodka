class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :from_transaction_id, references: :transactions
      t.integer :to_transaction_id, references: :transactions
      t.integer :from_account_id, references: :accounts
      t.integer :to_account_id, references: :accounts
      t.decimal :amount_cents, null: false, default: 0, precision: 8, scale: 0
      t.string :currency, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
