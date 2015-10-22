Rails.application.routes.draw do
  root 'accounts#index'

  resources :accounts do
    patch :default
  end

  resources :transactions
  resources :reconciliations
  resources :categories, except: [:show, :new]
  resources :transfers, except: [:show, :edit, :update]

  get 'budget' => 'budget#show', as: :current_budget

  scope 'budget/:year/:month', constraints: { :format => /(js|json)/ } do
    resource :budget, only: :show, shallow: true, path: ''
    resources :budget_categories, only: [:show, :update], shallow: true, path: ''
  end
end
