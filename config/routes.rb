Rails.application.routes.draw do
  resources :bookings
  resources :houses
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/filtered_houses' => 'houses#filtered_houses', :as => :some_name
  get '/booking_house' => 'houses#book_house', :as => :same_name
end

