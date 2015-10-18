class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :code, null: false, default: ''
      t.string :title, null: false
      t.string :description, null: false, default: ''

      t.timestamps null: false
    end
  end
end
