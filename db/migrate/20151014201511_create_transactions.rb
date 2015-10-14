class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id
      t.integer :amount_cents
      t.string :currency
      t.integer :category_id
      t.string :description

      t.timestamps null: false
    end
  end
end
