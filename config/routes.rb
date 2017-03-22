Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # devise_for :admins do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  resources :catalogues
  root to: 'catalogues#index'
  get "/contact", to: "catalogues#contact"
  get "/catalogues/:id/:subid", to: "catalogues#subfolder"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
