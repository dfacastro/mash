Mash::Application.routes.draw do
  
  get "downloads/get"
  get "downloads/download", :as => :download

  get "comment/create"

  #resources :ratings

=begin
  get "session/new"

  get "session/create"

  get "session/destroy"
=end
  resources :users
  match 'confirm_account', :to => 'users#confirm_account', :method => :post

  get "home/index"

  #resources :musics
  controller :musics do
    get 'upload' => :new
    post 'upload' => :create
    get 'listen' => :show
    get 'download' => :download
    delete 'listen' => :destroy
    get 'my_uploads' => :my_uploads
  end
  
  match 'music/:music_id/rate' => 'ratings#rate', :as => :rate, :via => :post
  match 'music/:music_id/comment' => 'comments#create', :as => :comment, :via => :post
  match 'comment' => 'comments#destroy', :as => :del_comment, :via => :delete
  match 'comment' => 'comments#update', :as => :updt_comment, :via => :post
  
  controller :session do
    #get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

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

  root :to => 'home#index', :as => 'home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
