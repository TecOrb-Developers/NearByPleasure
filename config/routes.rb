Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get 'page1'=>"home#new"
  get 'page2'=>"home#details"
  resources :upload_csv,:only =>[:index,:create]
  resources :subcategories
  resources :business
  get 'update_lat_long'=>"upload_csv#update_lat_long"
  get 'update_image'=>'upload_csv#update_image'
  post 'lat_long_csv'=>"upload_csv#lat_long_csv"

  #===========APIS============================================

  post 'signup'=>"users#signup"
  get 'user/:user_id/token/:token/confirm'=>"users#confirm",:as=> "confirm"
  post 'add_talk'=>"talks#create_talk"
  post 'all_talk'=>"talks#all_talk"
  post 'my_talk'=>"talks#my_talk"
  post 'create_comment'=>"comments#create_comment"
  post 'remove_talk'=>"talks#remove_talk"
  post 'all_category'=>"categories#all_category"
  post 'find_category'=>"categories#find_category"
  post 'create_bookmark'=>"bookmarks#create_bookmark"
  post 'remove_bookmark'=>"bookmarks#remove_bookmark"
  post 'create_review'=>"reviews#create_review"
  post 'my_reviews'=>"reviews#my_reviews"
  post 'all_reviews'=>"reviews#all_reviews"
  post 'user_reviews'=>"reviews#user_reviews"
  post 'search_title'=>'titles#search_title'
  post 'recent_service'=>"recent_checks#recent_service"

  post 'all_recent'=>"recent_checks#all_recent"
  post 'search_bookmark'=>'bookmarks#search_bookmark'
  get 'payment_mode'=>'business#payment_mode',:as=>"payment"
  post 'user_signin'=>"business#user_signin",:as=>"user_signin"
  get 'business/:user_id/welcome'=>"business#welcome", as: :welcome
  post 'user_login'=>"business#user_login",:as=>"user_login"
  get 'business/:user_id/paid_user'=>"business#paid_user",:as=>"paid_user"
  get 'business/:user_id/logout'=>"business#logout",:as=>"logout"
  post "add_business"=>"business#add_business",:as=>"add_business"
  get "add_business_form"=>"business#add_business_form",:as=>"add_business_form"
  get "business/:id/my_business"=>"business#my_business",:as=>"my_business"
  get "business/:id/profile"=>"business#profile",:as=>"profile"
  get "business/:id/setting"=>"business#setting",:as=>"setting"
 

  post 'socialauth'=>"users#socialauth"

  post 'login'=>"sessions#login"
  post 'forgot_password'=>"sessions#forgot_password"
  get 'forgot/:user_id/token/:token'=>"sessions#forgot_view",:as=>"forgot_view"
  post 'update_password'=>"sessions#update_password"

  post 'all_subcategories'=>"subcategories#subcategories"
  post 'find_subcategory'=>"subcategories#find_subcategory"

  post 'join_talk'=>"talks#join_talk"
  post 'leave_talk'=>"talks#leave_talk"
  post 'my_bookmarks'=>"bookmarks#my_bookmarks"

  post 'profile'=>"users#profile"
  post 'update_profile'=>"users#update_profile"
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
