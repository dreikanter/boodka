class AddReconsiliationToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :reconsiliation, :boolean, default: false
  end
end
