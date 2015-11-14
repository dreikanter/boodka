class AddDetailsToTransfer < ActiveRecord::Migration
  def change
    add_monetize :transfers, :amount
    add_column :transfers, :from_account_id, :integer
    add_column :transfers, :to_account_id, :integer

    Transfer.all.each do |transfer|
      from = transfer.transactions.where(direction: Const::OUTFLOW).first
      to = transfer.transactions.where(direction: Const::INFLOW).first

      transfer.update(
        amount_cents: to.amount_cents,
        amount_currency: to.amount_currency,
        from_account_id: from.account_id,
        to_account_id: to.account_id
      )
    end

    change_column_null :transfers, :from_account_id, false
    change_column_null :transfers, :to_account_id, false
  end
end
