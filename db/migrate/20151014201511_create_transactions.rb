class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id, null: false
      t.decimal :amount_cents, null: false, default: 0, precision: 8, scale: 0
      t.string :currency, null: false
      t.decimal :calculated_amount_cents, null: false, default: 0, precision: 8, scale: 0
      t.float :rate, null: false, default: 1.0
      t.integer :category_id
      t.integer :transfer_id
      t.string :description, null: false, default: ''

      t.timestamps null: false
    end
  end
end
