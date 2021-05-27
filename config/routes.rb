Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  post "users/edit" => "users#send_mail"
  get 'broadcast/new' => "broadcast#new"
  post'broadcast/new' => "broadcast#new"
  post 'broadcast/mail_entry'=> "broadcast#create"
  get 'broadcast/mail_entry'=> "broadcast#mail_entry"
  get 'broadcast/confirm_email'
  get 'broadcast/preview_all'
  get 'broadcast/sent_message'
  get "delete_filename"=> "broadcast#delete_filename"
  get "broadcast/download" =>"broadcast#download"
  post "broadcast/confirm_email" => "broadcast#confirm_email"
  post "broadcast/update" => "broadcast#update"
  root             'sessions#new_user'
  get 'signup'  => 'users#new'
  get    'admin'   => 'sessions#new'
  post   'admin'   => 'sessions#create'
  get 'login_user' =>"broadcast#new"
  post 'login_user' =>'sessions#create_user'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :session
  resources :broadcast do
    collection { post :import }

  end
end
