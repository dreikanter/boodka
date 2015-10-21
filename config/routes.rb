Rails.application.routes.draw do
  root 'accounts#index'

  resources :accounts do
    patch :default
  end

  resources :transactions
  resources :reconciliations
  resources :categories, except: [:show, :new]
  resources :transfers, except: [:show, :edit, :update]

  resource :budget,
            only: [:show, :new, :edit, :destroy],
            path: 'budget/:year/:month',
            controller: :budget,
            constraints: { year: /\d+/, month: /\d+/ }
end
