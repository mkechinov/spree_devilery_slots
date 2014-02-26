Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :delivery_slots
    resources :delivery_exceptions
    resources :delivery_cities
  end
end
