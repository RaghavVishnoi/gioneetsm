Rails.application.routes.draw do
 
  resources :user_parents
  resources :designations
  resources :roles
  resources :permissions
  resources :module_groups
  get '/users/change_status'
  post '/users/reporting_manager'
   post '/downloads/mum_list_based_on_nd'
  get '/users/reset_password'
  post '/users/reset_password' => 'users#change_password' 

   post '/users/mum'
  post '/users/rds'
 
  resources :users 
  
  root "sessions#new"

  get  'forgot_password' =>'passwords#new',as: :passwords_new

  resources :passwords, only: [:create, :new, :update]
  resources :sessions, only: [:create,:destroy]
  get 'login' => 'sessions#new', as: :sign_in
  
    
  resources :users, only: [:create,:new] do
    resource :password, only: [:create, :edit, :update]
  end

  resources :permit_roles
  
  resources :sales_beats, only: [:index,:create,:new,:show]
  resources :targets
  resources :retailers, only: [:index,:create,:new,:show]
  resources :images
  resources :downloads
  post '/retailers/is_visited'

  namespace :api do
    namespace :v1 do
      resources :models, only: [:index]
      resources :sessions, only: [:create]
      resource :session, only: [:destroy]
      resources :passwords, only: [:create]
      resource :password,only: [:update]
      post  "/users/change_password", to: 'users#change_password' 
      get "/zsales/search", to: 'zsales#search'
      post "/zsales/assignment"
      post "/zsales/rds"
      post "/user", to: 'users#update'
      get "/versions", to: 'versions#index'
      post "/crash_reports", to: 'crash_reports#create'
      #resource :user,only: [:update]
    end
  end

  namespace :api do
    namespace :v2 do
      post "/zsales/rds" 
      post "/zsales/assignment"
    end
  end
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
