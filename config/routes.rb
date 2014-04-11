Rails.application.routes.draw do

  as :person do
    get 'login' => 'devise/sessions#new', :as => :new_person_session
    post 'logout' => 'devise/sessions#create', :as => :person_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_person_session
    patch '/person/confirmation' => 'confirmations#update', :via => :patch, :as => :update_person_confirmation
  end
  devise_for :people, :skip => [:sessions], :controllers => {:registrations => "registrations", :confirmations => "confirmations"}

  root "welcome#index"
  # family routes
  
  get 'families/new' => "family#new", as: "new_family"

  get 'families/add_member' => "family#add_member_input", as: "add_member"
  
  get 'families/:id/about_us' => "family#about_us", as: "about_us"

  get "families/:id" => "family#show", as: "family"
  
  post 'families' => "family#create"

  # album routes

  get 'families/:id/albums' => "albums#index", as: 'albums'
  
  get 'families/:id/albums/new' => "albums#new", as: 'new_album'

  get 'families/:id/albums/:album_id/edit' => "albums#edit", as: 'edit_album'
  
  get 'families/:id/albums/:album_id' => "albums#show", as: 'album'

  post 'families/:id/albums' => "albums#create", as: "family_albums"

  patch 'families/:id/albums/:album_id' => "albums#update", as: "update_family_albums"
  
  delete 'families/:id/albums/:album_id' => "albums#destroy", as: 'destroy_album'
  
  # photo routes

  post 'families/:id/albums/:album_id/photos' => "photos#create", as: "create_photo"
  
  delete 'families/:id/albums/:album_id/photos/:photo_id' => "photos#destroy", as: "destroy_photo"

  # conversation routes

  get "/families/:id/conversations" => "conversations#index", as: "family_conversations"

  post "/families/:id/conversations" => "converstions#create", as: "create_family_conversations"

  delete "/families/:id/converastions" => "conversations#destroy", as: "delete_family_conversations"

  # message routes

  get "/families/:id/conversations/:conversation_id/messages" => "messages#index", as: "family_messages"

  post "/families/:id/conversations/:conversation_id/messages" => "messages#create", as: "create_family_messages"

  delete "/families/:id/conversations/:conversation_id/messages" => "messages#destroy", as: "destroy_family_messages"



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
