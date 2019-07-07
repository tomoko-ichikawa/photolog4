Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  root 'photos#index'
  devise_for :users
  resources :photos do
      collection do
            post:confirm
      end
  end
  resources :users, controller => {
      registrations => 'users/registrations'
  }
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
