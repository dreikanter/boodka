class AccountsController < ApplicationController
  before_action :load_account, only: [:edit, :update]
  before_action :set_form, only: [:create, :update]

  def new
    @form = AccountForm.new
  end

  def create
    AccountBuilder.build!(@form)
    redirect_to accounts_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :new
  end

  def edit
  end

  def update
    AccountBuilder.update!(@form)
    redirect_to accounts_path, flash: { notify: 'Account updated' }
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :edit
  end

  def default
    account = Account.default!(account_id)
    message = "#{account.title} is now default"
    redirect_to accounts_url, flash: { notify: message }
  end

  private

  def account_id
    params.require(:account_id)
  end

  def id
    params.require(:id)
  end

  def load_account
    @account = Account.find(id)
  end

  def set_form
    @form = AccountForm.new(params)
  end
end
