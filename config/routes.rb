Rails.application.routes.draw do
  resources :attendances
  devise_for :employees
  get '/attendances/:id/:yyyymm' => 'attendances#month', as: 'month'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
