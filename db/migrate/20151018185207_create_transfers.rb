class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
