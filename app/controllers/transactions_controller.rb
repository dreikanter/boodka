class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:edit, :update, :destroy]

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

  def destroy
    fail if @transaction.transfer
    @transaction.destroy
    redirect_to transactions_url, notice: 'Transaction destroyed'
  end

  private

  def permitted_params
    [:account_id, :amount, :currency, :description, :category_id, :created_at]
  end

  def transaction_params
    params.require(:transaction).permit(permitted_params)
  end

  def processed_params
    transaction_params.merge(created_at: created_at)
  end

  def created_at
    Date.strptime(params[:created_at], Const::DATEPICKER_FORMAT_PARSE)
  end

  def transaction_id
    params.require(:id)
  end

  def load_transaction
    @transaction = Transaction.find(transaction_id)
  end
end
