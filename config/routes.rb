Rails.application.routes.draw do
  get 'broadcast/new'
  get 'broadcast/mail_entry'
  get 'broadcast/confirm_email'
  get 'broadcast/preview_all'
  get 'broadcast/sent_message'
  post 'fileuploads' => 'broadcast#create'

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
