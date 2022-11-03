Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
      post  '/subscriptions/subscribe', to: 'customer_subscriptions#create'
      patch '/subscriptions/unsubscribe', to: 'customer_subscriptions#update'
      get '/customers/:id/subscriptions', to: 'customer_subscriptions#index'
    end 
  end
end 
