Rails.application.routes.draw do
  root 'photos#index'
  root 'favorites#index'
  
  devise_for :users, controllers: {
          registrations: 'users/registrations'
  }
  
  resources :photos do
      resource :favorites, only: [:create, :destroy, :show]
      collection do
            post:confirm
      end
  end
  
  resources :users
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end

