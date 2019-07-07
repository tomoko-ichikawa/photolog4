Rails.application.routes.draw do
  root 'photos#index'
  
  devise_for :users, controllers: {
          registrations: 'users/registrations'
  }
  
  resources :photos do
      resources :favorites, only: [:create, :destory]
      collection do
            post:confirm
      end
  end
  
  resources :users
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end

