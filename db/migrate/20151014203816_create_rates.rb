class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :ask, null: false
      t.float :bid, null: false
      t.float :rate, null: false
      t.string :from, null: false
      t.string :to, null: false

      t.timestamps null: false
    end
  end
end
