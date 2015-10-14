class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :currency
      t.integer :amount
      t.string :title

      t.timestamps null: false
    end
  end
end
