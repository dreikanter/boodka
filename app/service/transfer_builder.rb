class TransferBuilder
  def self.build!(params)
    new(params).build!
  end

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def build!
    Transfer.transaction do
      create_transactions! create_transfer!
    end
  end

  private

  def create_transfer!
    Transfer.create!(description: generated_description)
  end

  def create_transactions!(transfer)
    belongings = transfer.transactions
    belongings.create!(from_transaction_params)
    belongings.create!(to_transaction_params)
  end

  def generated_description
    return params[:description] unless params[:description].blank?
    "#{amount.format} from #{from_account.title} to #{to_account.title}"
  end

  def from_account
    Account.find(params[:from_account_id])
  end

  def to_account
    Account.find(params[:to_account_id])
  end

  def amount
    currency = Money::Currency.new(params[:currency])
    Money.new(params[:amount].to_f, currency) * currency.subunit_to_unit
  end

  def from_transaction_params
    {
      amount_cents: amount.cents,
      amount_currency: amount.currency,
      direction: :outflow,
      account_id: params[:from_account_id],
      description: generated_description
    }
  end

  def to_transaction_params
    {
      amount_cents: amount.cents,
      amount_currency: amount.currency,
      direction: :inflow,
      account_id: params[:to_account_id],
      description: generated_description
    }
  end
end
