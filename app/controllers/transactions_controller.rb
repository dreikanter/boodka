class TransactionsController < ApplicationController
  def index
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    begin
      @transaction.save!
      redirect_to transactions_path
    rescue => e
      flash.now[:alert] = e.message
      render :index
    end
  end

  def edit
  end

  private

  def permitted_params
    [:account_id, :amount, :currency, :description]
  end

  def transaction_params
    params.require(:transaction).permit(permitted_params)
  end
end
