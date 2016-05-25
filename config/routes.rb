Rails.application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'page1'=>"home#new"
  get 'page2'=>"home#details"
  resources :upload_csv,:only =>[:index,:create]
  resources :subcategories
  get 'update_lat_long'=>"upload_csv#update_lat_long"
  get 'update_image'=>'upload_csv#update_image'
  post 'lat_long_csv'=>"upload_csv#lat_long_csv"

  #===========APIS============================================

  post 'signup'=>"users#signup"
  get 'user/:user_id/token/:token/confirm'=>"users#confirm",:as=> "confirm"
  post 'create_talk'=>"talks#create_talk"
  post 'all_talk'=>"talks#all_talk"
  post 'my_talk'=>"talks#my_talk"
  post 'create_comment'=>"comments#create_comment"
  post 'remove_talk'=>"talks#remove_talk"
  post 'all_category'=>"categories#all_category"
  post 'create_bookmark'=>"bookmarks#create_bookmark"
  post 'remove_bookmark'=>"bookmarks#remove_bookmark"
  post 'create_review'=>"reviews#create_review"

  post 'socialauth'=>"users#socialauth"

  post 'login'=>"sessions#login"
  post 'forgot_password'=>"sessions#forgot_password"
  get 'forgot/:user_id/token/:token'=>"sessions#forgot_view",:as=>"forgot_view"
  post 'update_password'=>"sessions#update_password"

  #============================================================
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
