class CreateTransfers < ActiveRecord::Migration[4.2]
  def change
    create_table :transfers do |t|
      t.string :memo

      t.timestamps null: false
    end
  end
end
