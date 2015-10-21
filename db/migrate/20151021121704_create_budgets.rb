class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :memo, null: false, default: ''

      t.timestamps null: false
    end
  end
end