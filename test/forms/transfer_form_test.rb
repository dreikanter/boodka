require 'test_helper'

describe TransferForm do
  def transfer_form_params_hash_name
    TransferForm.name.underscore.to_sym
  end

  SAMPLE_DESCRIPTION = 'Sample transfer'
  SAMPLE_CURRENCY = 'USD'
  SAMPLE_AMOUNT = 1000
  WITHDRAW_TRANSACTION_ID = 1
  DEPOSIT_TRANSACTION_ID = 2

  let(:sample_amount) { Money.new(SAMPLE_AMOUNT, SAMPLE_CURRENCY) }

  let(:request_params) do
    ActionController::Parameters.new({
      transfer_form_params_hash_name => {
        amount: SAMPLE_AMOUNT.to_s,
        amount_currency: SAMPLE_CURRENCY,
        from_account_id: WITHDRAW_TRANSACTION_ID,
        to_account_id: DEPOSIT_TRANSACTION_ID,
        description: SAMPLE_DESCRIPTION
      }
    })
  end

  let(:transfer_form) { TransferForm.new(request_params) }

  it 'process transfer params' do
    transfer_form.transfer_params.must_equal({
      description: SAMPLE_DESCRIPTION
    })
  end

  it 'process withdraw transaction params' do
    transfer_form.from_transaction_params.must_equal({
      amount: -Money.new(SAMPLE_AMOUNT, SAMPLE_CURRENCY),
      account_id: WITHDRAW_TRANSACTION_ID
    })
  end

  it 'process deposit transaction params' do
    transfer_form.to_transaction_params.must_equal({
      amount: Money.new(SAMPLE_AMOUNT, SAMPLE_CURRENCY),
      account_id: DEPOSIT_TRANSACTION_ID
    })
  end
end
