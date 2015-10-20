FactoryGirl.define do
  factory :account_form_params, class: Hash do
    title 'Account title'
    default 'false'
    currency 'USD'
    description 'Account description'
    amount '1000'
    created_at 1.day.ago
    initialize_with { attributes }
  end

  factory :default_account_form_params, parent: :account_form_params do
    default 'true'
  end

  factory :account_form_request, class: ActionController::Parameters do
    initialize_with do
      params = build(:account_form_params)
      new(AccountForm.name.underscore.to_sym => params)
    end
  end

  factory :default_account_form_request, class: ActionController::Parameters do
    initialize_with do
      params = build(:default_account_form_params)
      new(AccountForm.name.underscore.to_sym => params)
    end
  end

  factory :account_form, class: AccountForm do
    initialize_with { new build(:account_form_request) }
  end

  factory :default_account_form, class: AccountForm do
    initialize_with { new build(:default_account_form_request) }
  end
end
