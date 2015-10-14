class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :rate, null: false
      t.string :from, null: false
      t.string :to, null: false

      t.timestamps null: false
    end
  end
end
