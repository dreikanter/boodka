class TransactionsController < ApplicationController
  before_action :check_availability
  before_action :load_transaction, only: [:edit, :update, :destroy]

  def new
    @transaction = Transaction.new
    @transactions = Transaction.recent_history
  end

  def create
    @transaction = Transaction.new(complemented_params)
    begin
      @transaction.save!
      redirect_to new_transaction_path, notice: 'Transaction created'
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.message
      render :new
    end
  end

  def edit
  end

  def update
    @transaction.assign_attributes(complemented_params)
    begin
      @transaction.save!
      redirect_to new_transaction_path, notice: 'Transaction updated'
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.message
      render :edit
    end
  end

  def destroy
    fail if @transaction.transfer?
    @transaction.destroy
    redirect_to :back, notice: 'Transaction destroyed'
  end

  private

  def permitted_params
    [
      :account_id,
      :amount,
      :amount_currency,
      :direction,
      :memo,
      :category_id,
      :created_at
    ]
  end

  def complemented_params
    transaction_params.merge(direction: direction)
  end

  def transaction_params
    params.require(:transaction).permit(permitted_params)
  end

  def inflow?
    transaction_params[:direction] == 'inflow'
  end

  def direction
    inflow? ? Const::INFLOW : Const::OUTFLOW
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

  def check_availability
    return if Account.any?
    message = 'At least one accounts is required to add a transaction.'
    redirect_to(accounts_path, alert: message)
  end
end
