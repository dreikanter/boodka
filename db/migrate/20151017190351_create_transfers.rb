class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :source_id, null: false
      t.integer :destination_id, null: false

      t.timestamps null: false
    end
  end
end
