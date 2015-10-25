class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :period_id, null: false
      t.integer :category_id, null: false
      t.monetize :amount, null: false, default: 0
      t.string :memo, null: false, default: ''

      t.timestamps null: false
    end
  end
end
