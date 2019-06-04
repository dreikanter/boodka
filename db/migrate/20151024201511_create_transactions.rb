class CreateTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :transactions do |t|
      t.integer :account_id, null: false
      t.integer :direction, null: false, default: 0
      t.monetize :amount, null: false, default: 0
      t.monetize :calculated_amount, null: false, default: 0
      t.float :rate, null: false, default: 1.0
      t.integer :category_id
      t.integer :transfer_id
      t.string :memo, null: false, default: ''

      t.timestamps null: false
    end
  end
end
