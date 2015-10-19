Rails.application.routes.draw do
  get 'reconciliations/index'

  root 'accounts#index'
  resources :accounts do
    patch :default
  end

  resources :transactions
  resources :reconciliations
  resources :categories, except: [:show, :new]
  resources :transfers, except: [:show, :edit, :update]
end
