Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'logout', to: 'users/sessions#destroy'
  get 'sign_in', to: 'users/sessions#new'
  post 'sign_in', to: 'users/sessions#create'
  get 'sign_up', to: 'users/users#new'
  post 'sign_up', to: 'users/users#create'
  

  resources :users, :only => [:index]
  scope :module => 'users' do
    resources 'users', :only => [:show, :edit, :update] do
      resources :tasks
    end
  end
  

  root 'users/tasks#index'
end
