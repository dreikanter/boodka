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

  let(:sample_amount) do
    Money.new(SAMPLE_AMOUNT * TransferForm::CENTS_IN_UNIT, SAMPLE_CURRENCY)
  end

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

  let(:empty_transfer_form) { TransferForm.new }

  it 'process transfer params' do
    transfer_form.transfer_params.must_equal({
      description: SAMPLE_DESCRIPTION
    })
  end

  it 'process withdraw transaction params' do
    transfer_form.from_transaction_params.must_equal({
      amount: -sample_amount,
      account_id: WITHDRAW_TRANSACTION_ID
    })
  end

  it 'process deposit transaction params' do
    transfer_form.to_transaction_params.must_equal({
      amount: sample_amount,
      account_id: DEPOSIT_TRANSACTION_ID
    })
  end

  it 'could be empty' do
    empty_transfer_form.transfer_params.must_equal({
      description: nil
    })
    empty_transfer_form.from_transaction_params.must_equal({
      amount: Money.new(0),
      account_id: nil
    })
    empty_transfer_form.to_transaction_params.must_equal({
      amount: Money.new(0),
      account_id: nil
    })
  end
end
