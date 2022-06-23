Rails.application.routes.draw do
 
  devise_for :employees, controllers: {
    :registrations => 'employees/registrations',
    :sessions => 'employees/sessions',
    :passwords => 'employees/passwords'
  }
  resources :attendances do
    collection do
      get :month
      get :week
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
