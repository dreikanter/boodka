class AccountBuilder
  def self.build!(account_form)
    new(account_form).build!
  end

  def self.update!(account_form)
    new(account_form).update!
  end

  attr_reader :form

  def initialize(account_form)
    @form = account_form
  end

  def build!
    account = Account.create!(form.account_params)
    account.reconciliations.create!(form.reconciliation_params)
  end

  def update!

  end
end
