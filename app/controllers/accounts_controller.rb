class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit
  end

  private

  def account_id
    params.require(:id)
  end
end
