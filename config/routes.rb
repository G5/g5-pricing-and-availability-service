G5PricingService::Application.routes.draw do

  mount G5Updatable::Engine => '/g5_updatable'
  root 'locations#index'

  resources :locations do
    resources :floor_plans
  end

  get '/locations/:id/widget', to: 'locations#widget'
  get 'summary/index'
end
