class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :period_id, null: false
      t.integer :category_id, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :amount_cents, default: 0, null: false
      t.integer :spent_cents, default: 0, null: false
      t.integer :balance_cents, default: 0, null: false
      t.string :currency, null: false
      t.string :memo, null: false, default: ''

      t.timestamps null: false
    end
  end
end
