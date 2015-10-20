class AccountsController < ApplicationController
  before_action :set_new_form, only: [:new, :create]

  def create
    if @form.validate(params[:account])
      @form.save do |hash|
        account = Account.create!(hash[:account])
        account.reconciliations.create!(hash[:reconciliation])
      end
      redirect_to accounts_path, notify: 'Account created'
    else
      flash.now[:alert] = @form.errors.messages
      render :new
    end
  end

  def edit
    @form = edit_account_form(Account.find(id))
  end

  def update
    AccountBuilder.update!(id, @form)
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

  def new_account_form(account, reconciliation)
    NewAccountForm.new(account: account, reconciliation: reconciliation)
  end

  def edit_account_form(account)
    EditAccountForm.new(account)
  end

  def set_new_form
    @form = new_account_form(Account.new, Reconciliation.new)
  end
end
