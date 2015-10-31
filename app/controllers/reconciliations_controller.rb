class ReconciliationsController < ApplicationController
  before_action :check_availability
  before_action :load_accounts, except: :destroy
  before_action :load_reconciliation, only: [:edit, :update, :destroy]
  before_action :new_reconciliation, only: [:index, :new]

  def index
    load_reconciliations
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
    [:account_id, :amount, :created_at]
  end

  def rec_params
    params.require(:reconciliation).permit(permitted_params)
  end

  def load_reconciliation
    @reconciliation = Reconciliation.find(params.require(:id))
  end

  def check_availability
    fail 'No accounts to reconcile' unless Account.any?
  end

  def account_id
    params[:account_id]
  end

  def new_reconciliation_params
    return {} unless account_id
    account = Account.find(account_id)
    {
      account: account,
      amount: Calc.total(account: account)
    }
  end

  def new_reconciliation
    @reconciliation = Reconciliation.new(new_reconciliation_params)
  end

  def load_accounts
    @accounts = Account.decorate
  end

  def load_reconciliations
    @reconciliations = Reconciliation.recent_history.decorate
  end
end
