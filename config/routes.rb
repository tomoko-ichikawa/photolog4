Rails.application.routes.draw do
  root 'photos#index'
  devise_for :users
  resources :photos do
      collection do
            post:confirm
      end
  end
  resources :users, controllers: {
      registrations: 'users/registrations'
  }
end
