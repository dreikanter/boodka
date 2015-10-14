class CreatePlannedTransactions < ActiveRecord::Migration
  def change
    create_table :planned_transactions do |t|
      t.integer :account_id
      t.integer :amount_cents
      t.string :currency
      t.integer :category_id
      t.string :description
      t.datetime :start
      t.datetime :finish
      t.string :cron
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
