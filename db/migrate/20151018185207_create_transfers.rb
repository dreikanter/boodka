class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :memo

      t.timestamps null: false
    end
  end
end
