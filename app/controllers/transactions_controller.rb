class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:edit, :update]

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

  def update
    @transaction.assign_attributes(transaction_params)
    begin
      @transaction.save!
      redirect_to transactions_path, flash: { notify: 'Transaction updated' }
    rescue => e
      flash.now[:alert] = e.message
      render :edit
    end
  end

  private

  def permitted_params
    [:account_id, :amount, :currency, :description, :category_id]
  end

  def transaction_params
    params.require(:transaction).permit(permitted_params)
  end

  def transaction_id
    params.require(:id)
  end

  def load_transaction
    @transaction = Transaction.find(transaction_id)
  end
end
