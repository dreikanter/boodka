class TransfersController < ApplicationController
  before_action :check_availability

  def create
    @transfer = Transfer.new(form_params)
    begin
      @transfer.save!
      redirect_to new_transfer_path, notify: 'Transfer performed'
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.message
      render :new
    end
  end

  def new
    @transfer = Transfer.new(new_form_params)
    @transfers = Transfer.recent_history
  end

  def destroy
    Transfer.find(params[:id]).destroy
    redirect_to :back, notify: 'Transfer destroyed'
  end

  private

  PERMITTED_PARAMS = %i(
    memo
    created_at
    amount_cents
    amount_currency
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
end
