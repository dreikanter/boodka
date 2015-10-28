class AccountsController < ApplicationController
  before_action :init_new_form, only: [:new, :create]
  before_action :init_edit_form, only: [:edit, :update]

  def index
    @accounts = Account.ordered
    @totals_per_currency = totals_per_currency
    # @converted_equivalent = converted_equivalent
    @converted_equivalent = {}
  end

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

  def update
    if @form.validate(params[:edit_account])
      @form.save
      redirect_to accounts_path, notify: 'Account updated'
    else
      flash.now[:alert] = @form.errors.messages
      render :new
    end
  end

  def default
    account = Account.default!(account_id)
    message = "#{account.title} is now default"
    redirect_to accounts_url, notify: message
  end

  private

  def id
    params.require(:id)
  end

  def account_id
    params.require(:account_id)
  end

  def new_account_form(account, reconciliation)
    NewAccountForm.new(account: account, reconciliation: reconciliation)
  end

  def edit_account_form(account)
    EditAccountForm.new(account)
  end

  def init_new_form
    @form = new_account_form(Account.new, Reconciliation.new)
  end

  def init_edit_form
    @form = edit_account_form(Account.find(id))
  end

  def account_totals
    @accounts.map { |a| { currency: a.currency, amount: a.total } }
  end

  def grouped_account_totals
    account_totals.group_by { |item| item[:currency] }
  end

  def totals_per_currency
    Hash[grouped_account_totals.map {|k, v| [k, v.map { |a| a[:amount] }.sum]}]
  end

  def converted_equivalent
    Hash[@totals_per_currency.map { |currency, amount| [currency, @totals_per_currency.values.sum.exchange_to(currency)] }]
  end
end
