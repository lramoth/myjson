Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # API namespace
  # defaults to json, doesn't include /api/ in path
  # and restricted to the api subdomain
  # example: http://api.myjson.com/objects/:id
  namespace :api, :path => "", :constraints => {:subdomain => "api"} do
    # http://api.myjson.com/objects, always returns json, and only allows the following actions
    resources :objects, :defaults => {:format => :json}, :only => [:index, :create, :show, :update, :destroy]
    # http://api.myjson.com
    root :to => 'home#index', :defaults => {:format => :text}
  end

  # http://myjson.com
  root :to => 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
