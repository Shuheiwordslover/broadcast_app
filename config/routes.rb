Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'broadcast/new'
  post'broadcast/new'
  post 'broadcast/mail_entry'=> "broadcast#create"
  get 'broadcast/confirm_email'
  get 'broadcast/preview_all'
  get 'broadcast/sent_message'

  get "broadcast/mail_entry" => ""
  post "broadcast/confirm_email" => "broadcast#confirm_email"

  root             'sessions#new_user'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  post 'login_user' =>'sessions#create_user'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :session
  resources :broadcast do
    collection { post :import }

  end
end
