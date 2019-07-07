Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  root 'photos#index'
  
  resources :photos do
      collection do
            post:confirm
      end
  end
  
  resources :users, only: [:show]
  
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }
 
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
