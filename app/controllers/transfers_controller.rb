class TransfersController < ApplicationController
  before_action :load_transfer, only: :destroy

  def index
    @form = TransferForm.new
    @transfers = Transfer.recent_history
  end

  def create
    TransferBuilder.build!(form)
    redirect_to transfers_url, notice: 'Transfer was successfully created'
  rescue ActiveRecord::RecordInvalid => e
    @form = form
    flash.now[:alert] = e.message
    render :index
  end

  def destroy
    @transfer.destroy
    redirect_to transfers_url, notice: 'Transfer was successfully destroyed'
  end

  private

  def form
    TransferForm.new(params)
  end

  def load_transfer
    @transfer = Transfer.find(params[:id])
  end
end
