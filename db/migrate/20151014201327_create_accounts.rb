class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.string :currency, null: false
      t.string :title, null: false
      t.string :memo, null: false, default: ''
      t.boolean :default, null: false, default: false

      t.timestamps null: false
    end
  end
end
