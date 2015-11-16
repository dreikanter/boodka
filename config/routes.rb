Rails.application.routes.draw do
  root 'periods#show'

  resources :accounts do
    patch :default
  end

  resources :transactions
  resources :reconciliations
  resources :categories, except: :show
  resources :transfers, except: [:show]

  scope 'budget(/:year/:month)' do
    resource :period, only: :show, shallow: true, path: ''
    resources :budgets, only: :update, shallow: true,
              path: 'categories', constraints: { :format => /(js|json)/ }
  end

  scope 'operations(/:year/:month)' do
    resources :operations, only: :index, shallow: true, path: ''
  end
end
