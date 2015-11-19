Rails.application.routes.draw do
  root 'periods#show'

  resources :accounts do
    patch :default
  end

  resources :transactions
  resources :reconciliations
  resources :categories, except: :show
  resources :transfers, except: :show

  def period_defaults
    now = Time.current
    { year: now.year, month: now.month }
  end

  get 'budget' => 'periods#show', as: :current_period
  get 'operations' => 'operations#index', as: :current_operations

  scope 'budget/:year/:month', defaults: period_defaults do
    resource :period, only: :show, shallow: true, path: ''
    resources :budgets, only: :update, shallow: true,
              path: 'categories', constraints: { format: /(js|json)/ }
  end

  scope 'operations/:year/:month', defaults: period_defaults do
    resources :operations, only: :index, shallow: true, path: ''
  end
end
