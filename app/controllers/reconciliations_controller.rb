class ReconciliationsController < ApplicationController
  before_action :load_reconciliation, only: [:edit, :update, :destroy]

  def index
    @reconciliation = Reconciliation.new
  end

  def create
    @reconciliation = Reconciliation.new(rec_params)
    begin
      @reconciliation.save!
      redirect_to reconciliations_path
    rescue => e
      flash.now[:alert] = e.message
      render :index
    end
  end

  def edit
  end

  def update
    @reconciliation.assign_attributes(rec_params)
    begin
      @reconciliation.save!
      redirect_to reconciliations_path, notify: 'Reconciliation updated'
    rescue => e
      flash.now[:alert] = e.message
      render :edit
    end
  end

  def destroy
    @reconciliation.destroy
    redirect_to reconciliations_path, notify: 'Reconciliation destroyed'
  end

  private

  def permitted_params
    [:account_id, :amount]
  end

  def rec_params
    params.require(:reconciliation).permit(permitted_params)
  end

  def rec_id
    params.require(:id)
  end

  def load_reconciliation
    @reconciliation = Reconciliation.find(rec_id)
  end
end
