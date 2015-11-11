class TransactionsController < ApplicationController
  before_action :check_availability
  before_action :load_transaction, only: [:edit, :update, :destroy]

  def new

    @transaction = Transaction.new(new_form_params)
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

  PERMITTED_PARAMS = %i(
      account_id
      amount
      amount_currency
      direction
      memo
      category_id
      created_at
    )

  def complemented_params
    form_params.merge(direction: direction)
  end

  def form_params
    params.require(:transaction).permit(PERMITTED_PARAMS)
  end

  def inflow?
    form_params[:direction] == 'inflow'
  end

  def direction
    inflow? ? Const::INFLOW : Const::OUTFLOW
  end

  def processed_params
    form_params.merge(created_at: created_at)
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

  def category_id
    params[:category_id]
  end

  def new_form_params
    category_id.present? ? { category: Category.find(category_id) } : {}
  end
end
