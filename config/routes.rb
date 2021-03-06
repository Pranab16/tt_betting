Demo::Application.routes.draw do
  get "login" => "authentication#login"
  post "login" => "authentication#authenticate"

  get "signup" => "authentication#signup"
  post "signup" => "authentication#create_user"

  get "logout" => "authentication#logout"

  root :to => "home#index"

  get "leader_board" => "home#leader_board"

  post "question/new" => "question#create"

  get "question/active" => "question#active"
  get "question/inactive" => "question#inactive"
  get "question/expired" => "question#expired"

  get "question/answered" => "question#answered"
  get "question/unanswered" => "question#unanswered"

  post "question/answer" => "question#answer"


  #get "view_question" => "home#view_question"
  #get "posts/new"
  #post "posts/new"
  #
  #get "welcome/test"

  resources :question

  #root to: "welcome#index"

   # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
