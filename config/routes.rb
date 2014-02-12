Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :delivery_slots
    resources :delivery_exceptions
  end

  get 'checkout/delivery_slots', to: 'checkout#delivery_slots'
end
