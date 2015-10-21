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
  resource :budget,
            only: [:show, :new, :edit, :destroy],
            path: 'budget/:year/:month',
            constraints: { year: /\d{1,10}/, month: /\d{1,10}/ }
end
