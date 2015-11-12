Rails.application.routes.draw do
  root 'accounts#index'

  resources :accounts do
    patch :default
  end

  resources :transactions
  resources :reconciliations
  resources :categories, except: :show
  resources :transfers, except: [:show]

  get 'budget' => 'periods#show', as: :current_period

  scope 'budget/:year/:month' do
    resource :period, only: :show, shallow: true, path: ''
    resources :budgets, only: :update, shallow: true,
              path: 'categories', constraints: { :format => /(js|json)/ }
  end

  get 'history' => 'operations#index', as: :current_operations

  scope 'history/:year/:month' do
    resources :operations, only: :index, shallow: true, path: ''
  end
end
