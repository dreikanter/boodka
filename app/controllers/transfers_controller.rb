class TransfersController < ApplicationController
  before_action :check_availability

  layout 'popup'

  def new
    @transfer = Transfer.new(new_form_params)
  end

  def create
    @transfer = Transfer.new(form_params)
    begin
      @transfer.save!
      redirect_to ops_path, notice: 'Transfer performed'
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.message
      render :new
    end
  end

  def edit
    @transfer = Transfer.find(transfer_id)
  end

  def update
    @transfer = Transfer.find(transfer_id)
    begin
      @transfer.update!(form_params)
      redirect_to ops_path, notice: 'Transfer updated'
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.message
      render :edit
    end
  end

  def destroy
    Transfer.find(params[:id]).destroy
    redirect_to ops_path, notice: 'Transfer destroyed'
  end

  private

  PERMITTED_PARAMS = %i(
    memo
    created_at
    amount
    from_account_id
    to_account_id
  )

  def form_params
    params[:transfer].permit(PERMITTED_PARAMS)
  end

  def from_account_id
    params[:from_account_id]
  end

  def new_form_params
    return {} unless from_account_id
    from_account = Account.find(from_account_id)
    { from_account_id: from_account.id, amount_currency: from_account.currency }
  end

  def check_availability
    return if Account.count > 1
    message = 'At least 2 accounts required to transfer.'
    redirect_to(accounts_path, alert: message)
  end

  def transfer_id
    params.require(:id)
  end

  def ops_path
    year = @transfer.created_at.year
    month = @transfer.created_at.month
    operations_path(year, month)
  end
end
