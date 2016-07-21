Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'logout', to: 'web/users/sessions#destroy'
  get 'sign_in', to: 'web/users/sessions#new'
  post 'sign_in', to: 'web/users/sessions#create'
  get 'sign_up', to: 'web/users/users#new'
  post 'sign_up', to: 'web/users/users#create'
  
  scope module: 'web' do
    scope module: 'admin' do
      resources :users, only: [:index]
      resources :tasks
    end

    scope module: 'users' do
      resources 'users', only: [:show, :edit, :update] do
        resources :tasks
      end
    end
  end  

  root 'web/admin/tasks#index'
end
