# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users, path: "/",
             path_names: { sign_in: :login, sign_out: :logout, registration: :users },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  resources :clients
  resources :rooms
  resources :fortunes, only: :index
end
