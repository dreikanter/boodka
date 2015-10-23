class TransfersController < ApplicationController
  before_action :check_availability
  before_action :init_new_form, only: [:index, :new, :create]
  before_action :load_transfer, only: :destroy

  def index
    @transfers = Transfer.recent_history
  end

  def create
    if @form.validate(params[:transfer])
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
    @transfer.destroy
    redirect_to transfers_url, notify: 'Transfer destroyed'
  end

  private

  def form
    TransferForm.new(params)
  end

  def load_transfer
    @transfer = Transfer.find(params[:id])
  end

  def init_new_form
    @form = TransferForm.new(Transfer.new)
  end

  def check_availability
    fail 'At least 2 accounts required to transfer' if Account.count < 2
  end
end
