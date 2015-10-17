class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id, null: false
      t.decimal :amount_cents, null: false, default: 0, precision: 8, scale: 0
      t.string :currency, null: false
      t.integer :category_id
      t.string :description, null: false, default: ''

      t.timestamps null: false
    end
  end
end
