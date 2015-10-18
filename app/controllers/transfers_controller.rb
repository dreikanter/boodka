class TransfersController < ApplicationController
  before_action :load_transfer, only: :destroy

  def index
    @transfer = Transfer.new
    @transfers = Transfer.all
  end

  def create
    begin
      @transfer = Transfer.create!(transfer_params)
      redirect_to transfers_url, notice: 'Transfer was successfully created'
    rescue => e
      @transfer = Transfer.new(transfer_params)
      flash.now[:alert] = e.message
      render :index
    end
  end

  def destroy
    @transfer.destroy
    redirect_to transfers_url, notice: 'Transfer was successfully destroyed'
  end

  private

  def permitted_params
    [:from_account_id, :to_account_id, :description, :amount, :currency]
  end

  def transfer_params
    params.require(:transfer).permit(permitted_params)
  end

  def currency
    params.require(:currency)
  end

  def from_account_id
    params.require(:from_account_id)
  end

  def load_transfer
    @transfer = Transfer.find(params[:id])
  end
end
