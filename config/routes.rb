Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :employees, only: [:create]
  get '/employees/tax_deduction', to: 'employees#tax_deduction'
end
