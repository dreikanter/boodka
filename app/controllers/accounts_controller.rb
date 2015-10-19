class AccountsController < ApplicationController
  before_action :load_account, only: [:edit,:update, :default]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    begin
      @account.save!
      redirect_to accounts_path
    rescue => e
      flash.now[:alert] = e.message
      render :new
    end
  end

  def edit
  end

  def update
    @account.assign_attributes(edit_account_params)
    begin
      @account.save!
      redirect_to accounts_path, flash: { notify: 'Account updated' }
    rescue => e
      flash.now[:alert] = e.message
      render :edit
    end
  end

  private

  def permitted_params
    [:title, :description, :id, :currency]
  end

  def account_params
    params.require(:account).permit(permitted_params)
  end

  def permitted_params_edit
    [:title, :description, :id, :currency]
  end

  def edit_account_params
    params.require(:account).permit(permitted_params_edit)
  end

  def title
    account_params[:title]
  end

  def description
    account_params[:description]
  end

  def id
    params.require(:id)
  end

  def load_account
    @account = Account.find(id)
  end
end
