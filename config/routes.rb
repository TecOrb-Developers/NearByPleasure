
Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # All routes
  get "dashboards/dashboard_1"
  get "dashboards/dashboard_2"
  get "dashboards/dashboard_3"
  get "dashboards/dashboard_4"
  get "dashboards/dashboard_4_1"
  get "dashboards/dashboard_5"

  get "layoutsoptions/index"
  get "layoutsoptions/off_canvas"

  get "graphs/flot"
  get "graphs/morris"
  get "graphs/rickshaw"
  get "graphs/chartjs"
  get "graphs/chartist"
  get "graphs/peity"
  get "graphs/sparkline"

  get "mailbox/inbox"
  get "mailbox/email_view"
  get "mailbox/compose_email"
  get "mailbox/email_templates"
  get "mailbox/basic_action_email"
  get "mailbox/alert_email"
  get "mailbox/billing_email"

  get "metrics/index"

  get "widgets/index"

  get "forms/basic_forms"
  get "forms/advanced"
  get "forms/wizard"
  get "forms/file_upload"
  get "forms/text_editor"

  get "appviews/contacts"
  get "appviews/profile"
  get "appviews/profile_two"
  get "appviews/contacts_two"
  get "appviews/projects"
  get "appviews/project_detail"
  get "appviews/file_menager"
  get "appviews/vote_list"
  get "appviews/calendar"
  get "appviews/faq"
  get "appviews/timeline"
  get "appviews/pin_board"
  get "appviews/teams_board"
  get "appviews/social_feed"
  get "appviews/clients"
  get "appviews/outlook_view"
  get "appviews/blog"
  get "appviews/article"
  get "appviews/issue_tracker"

  get "pages/search_results"
  get "pages/lockscreen"
  get "pages/invoice"
  get "pages/invoice_print"
  get "pages/login"
  get "pages/login_2"
  get "pages/forgot_password"
  get "pages/register"
  get "pages/not_found_error"
  get "pages/internal_server_error"
  get "pages/empty_page"

  get "miscellaneous/notification"
  get "miscellaneous/nestablelist"
  get "miscellaneous/timeline_second_version"
  get "miscellaneous/forum_view"
  get "miscellaneous/forum_post_view"
  get "miscellaneous/google_maps"
  get "miscellaneous/code_editor"
  get "miscellaneous/modal_window"
  get "miscellaneous/validation"
  get "miscellaneous/tree_view"
  get "miscellaneous/chat_view"
  get "miscellaneous/agile_board"
  get "miscellaneous/diff"
  get "miscellaneous/sweet_alert"
  get "miscellaneous/idle_timer"
  get "miscellaneous/spinners"
  get "miscellaneous/live_favicon"
  get "miscellaneous/masonry"

  get "uielements/typography"
  get "uielements/icons"
  get "uielements/draggable_panels"
  get "uielements/buttons"
  get "uielements/video"
  get "uielements/tables_panels"
  get "uielements/tabs"
  get "uielements/notifications_tooltips"
  get "uielements/badges_labels_progress"

  get "gridoptions/index"

  get "tables/static_tables"
  get "tables/data_tables"
  get "tables/foo_tables"
  get "tables/jqgrid"

  get "commerce/products_grid"
  get "commerce/products_list"
  get "commerce/product_edit"
  get "commerce/product_detail"
  get "commerce/orders"
  get "commerce/payments"

  get "gallery/basic_gallery"
  get "gallery/slick_carusela"
  get "gallery/bootstrap_carusela"

  get "cssanimations/index"

  get "landing/index"


  root 'home#index'
  get 'page1'=>"home#new"
  get 'page2'=>"home#details"
  get 'listing'=>"home#add_listing"
  resources :upload_csv,:only =>[:index,:create]
  resources :subcategories
  resources :business 
  resources :users do
    resources :tickets do 
      resources :ticket_comments
    end
  end
  resources :subcategories
  resources :demos
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
  post 'user_signup'=>"business#user_signup",:as=>"user_signup"
  get 'business/:user_id/welcome'=>"business#welcome", as: :welcome
  post 'user_login'=>"business#user_login",:as=>"user_login"
  get 'business/:user_id/paid_user'=>"business#paid_user",:as=>"paid_user"
  get 'business/:user_id/logout'=>"business#logout",:as=>"logout"
  post "add_business"=>"business#add_business",:as=>"add_business"
  get "add_business_form"=>"business#add_business_form",:as=>"add_business_form"
  get "business/:id/my_business"=>"business#my_business",:as=>"my_business"
  get "business/:id/profile"=>"business#profile",:as=>"profile"
  get "business/:id/setting"=>"business#setting",:as=>"setting"
  post "business/:id/change_password"=>"business#change_password",:as=>"change_password"
  get "business/:id/my_business_edit"=>"business#my_business_edit",:as=>"business_edit"
  get "forget_password"=>"password#forget_password",:as=>"business_forget_password"
  post "forgot_business_password"=>"password#forgot_business_password",:as=>"business_forgot_password"
  get 'business/:user_id/token/:token'=>"password#business_forgot_view",:as=>"business_forgot_view"
  post 'change_password'=>"password#change_password" ,:as=>"password_change"
  get 'change_business_password/:user_id/token/:token'=>"password#change_business_password" ,:as=>"change_business_password"
  post 'ticket_comments/:ticket_id/comment'=>"ticket_comments#create_admin_comment",:as=>"create_admin_comment"
  get 'tickets/:ticket_id/delete'=>"tickets#close_ticket",:as=>"close_ticket"
 

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

  get 'user_login'=>"sessions#index"
  get 'user_register'=>"users#new"

  get 'user_logout'=>"sessions#user_logout"
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
