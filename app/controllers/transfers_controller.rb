class TransfersController < ApplicationController
  before_action :check_availability
  before_action :init_new_form, except: :destroy

  def create
    if @form.validate(transfer_params)
      @form.save { |hash| TransferBuilder.build!(hash) }
      redirect_to new_transfer_path, notify: 'Transfer performed'
    else
      flash.now[:alert] = 'Something went wrong'
      render :new
    end
  end

  def new
    @transfers = Transfer.recent_history
  end

  def destroy
    Transfer.find(params[:id]).destroy
    redirect_to :back, notify: 'Transfer destroyed'
  end

  private

  def transfer_params
    params[:transfer].permit([
      :memo,
      :amount,
      :currency,
      :from_account_id,
      :to_account_id,
      :created_at
    ])
  end

  def form
    TransferForm.new(params)
  end

  def init_new_form
    @form = TransferForm.new(Transfer.new)
  end

  def check_availability
    return if Account.count > 1
    message = 'At least 2 accounts required to transfer.'
    redirect_to(accounts_path, alert: message)
  end
end
