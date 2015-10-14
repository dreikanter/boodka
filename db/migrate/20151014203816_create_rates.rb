class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :rate
      t.string :from
      t.string :to

      t.timestamps null: false
    end
  end
end
