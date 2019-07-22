Rails.application.routes.draw do

  root 'photos#index'
  root 'favorites#index'

  devise_for :users, controllers: {
          registrations: 'users/registrations'
  }

  resources :photos do
      resource :favorites, only: [:create, :destroy, :show]
      resources :comments

      collection do
            post:confirm
      end
  end

  resources :users
  resources :relationships, only: [:create, :destroy]


  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
