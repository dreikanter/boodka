class CreatePlannedTransactions < ActiveRecord::Migration
  def change
    create_table :planned_transactions do |t|
      t.integer :account_id, null: false
      t.decimal :amount_cents, null: false, precision: 8, scale: 0
      t.string :currency, null: false
      t.integer :category_id
      t.string :description, null: false, default: ''
      t.datetime :start
      t.datetime :finish
      t.string :cron, null: false, default: ''
      t.boolean :enabled, null: false, default: true

      t.timestamps null: false
    end
  end
end
