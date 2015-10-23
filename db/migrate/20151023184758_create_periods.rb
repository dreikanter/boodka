class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.string :memo, null: false, default: ''

      t.timestamps null: false
    end
  end
end
