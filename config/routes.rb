Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end
  get 'billing/show'
  get 'checkout/show'
  get 'checkout/cancel', to: 'checkout#cancel', as: 'checkout_cancel' # Add this line
  get 'checkout', to: 'checkout#show'
  get 'checkout/success', to: 'checkout#success'
  get 'billing', to: 'billing#show'
  post '/webhooks/stripe', to: 'webhooks#stripe'
end
