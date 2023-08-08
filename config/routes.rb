Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :bx_block_group do 
    resources :messages
    resources :group_conversations do 
      collection do 
        post :all_accounts
        post :group_information
        post :add_member
        post :view_schedule
        post :remove_member
        post :delete_group
        post :show_group_chat
      end
    end
  end

  namespace :bx_block_user do
    resources :user_conversations do 
      collection do 
        post :mute_chat
      end
    end
  end
end
