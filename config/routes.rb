Rails.application.routes.draw do

  get 'relationships/create'

  get 'relationships/destroy'

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
  resource :relationships, only: [:create, :destroy]


  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
