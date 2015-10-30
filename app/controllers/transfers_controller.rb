class TransfersController < ApplicationController
  before_action :check_availability, :load_accounts
  before_action :init_new_form, except: :destroy

  def index
    @transfers = Transfer.recent_history
  end

  def create
    if @form.validate(transfer_params)
      @form.save { |hash| TransferBuilder.build!(hash) }
      redirect_to transfers_path, notify: 'Transfer performed'
    else
      flash.now[:alert] = 'Something went wrong'
      @errors = @form.errors
      render :new
    end
  end

  def new
  end

  def destroy
    Transfer.find(params[:id]).destroy
    redirect_to transfers_url, notify: 'Transfer destroyed'
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
    fail 'At least 2 accounts required to transfer' if Account.count < 2
  end

  def load_accounts
    @accounts = Account.decorate
  end
end
