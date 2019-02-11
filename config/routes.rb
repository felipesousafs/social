Rails.application.routes.draw do
  get 'home/index'
  resources :strikes
  resources :messages
  resources :chats
  resources :followers
  resources :reactions
  resources :reaction_types
  resources :posts do
    post 'add_comment', to: 'posts#add_comment'
  end
  resources :blocked_users
  resources :friendships
  root to: 'home#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'my_timeline', to: 'users/users#my_timeline'
    get 'reenable', to: 'users/registrations#reenable'
    post 'reenable', to: 'users/registrations#confirm_reenable'
    get 'nearby', to: 'users/users#nearby'
    delete 'users/:id/destroy_location', to: 'users/users#destroy_location', as: :destroy_location
  end
  get 'users', to: 'users/users#index', as: 'users'
  get 'admin', to: 'home#admin', as: 'admin'
  scope 'friendship_requests' do
    put ':request_id/accept', to: 'friendships#accept_friendship', as: 'accept_friendship'
    get '', to: 'users/users#friendship_requests', as: 'user_friendship_requests'
  end
  scope 'users' do
    get ':id', to: 'users/users#show', as: 'user'
    get ':id/follow', to: 'users/users#follow', as: 'user_follow'
    get ':id/unfollow', to: 'users/users#unfollow', as: 'user_unfollow'
    get ':id/send_friend_request', to: 'users/users#send_friendship', as: 'send_friendship'
    get ':id/block', to: 'users/users#block_user', as: 'block_user'
    get ':id/unblock', to: 'users/users#unblock_user', as: 'unblock_user'
    get ':id/add_superuser', to: 'users/users#add_superuser', as: 'add_superuser'
    get ':id/remove_superuser', to: 'users/users#remove_superuser', as: 'remove_superuser'
  end

  # Admin feature
  get 'users/:id/disable', to: 'users/users#disable', as: 'user_disable'
  get 'users/:id/enable', to: 'users/users#enable', as: 'user_enable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
