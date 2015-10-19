class TransferBuilder
  def self.build!(transfer_form)
    new(transfer_form).build!
  end

  attr_reader :form

  def initialize(transfer_form)
    @form = transfer_form
  end

  def build!
    create_transactions! create_transfer!
  end

  private

  def create_transfer!
    params = form.transfer_params
    params[:description] = generated_description
    Transfer.create!(params)
  end

  def create_transactions!(transfer)
    belongings = transfer.transactions
    belongings.create!(with_description form.from_transaction_params)
    belongings.create!(with_description form.to_transaction_params)
  end

  def generated_description
    return description unless description.blank?
    "#{amount} #{currency} from #{from_account.title} to #{to_account.title}"
  end

  def with_description(params)
    params.merge(description: generated_description)
  end

  def from_account
    Account.find(form.from_account_id)
  end

  def to_account
    Account.find(form.to_account_id)
  end

  def description
    form.transfer_params[:description]
  end

  def amount
    form.to_transaction_params[:amount]
  end

  def currency
    form.to_transaction_params[:currency]
  end
end
