class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :currency, null: false
      t.integer :amount, null: false
      t.string :title, null: false, default: ''

      t.timestamps null: false
    end
  end
end
