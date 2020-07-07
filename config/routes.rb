Rails.application.routes.draw do
  
  devise_for :user
  root 'user#index'
  get 'user' => 'user#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
