class CreateBudgetCategories < ActiveRecord::Migration
  def change
    create_table :budget_categories do |t|
      t.integer :budget_id, null: false
      t.integer :category_id, null: false
      t.monetize :planned, null: false, default: 0
      t.string :memo, null: false, default: 0

      t.timestamps null: false
    end
  end
end
