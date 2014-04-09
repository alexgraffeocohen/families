Rails.application.routes.draw do
  
  get 'welcome/index'

  devise_for :people, :skip => [:sessions], :controllers => {:registrations => "registrations"}
  as :person do
    get 'login' => 'devise/sessions#new', :as => :new_person_session
    post 'logout' => 'devise/sessions#create', :as => :person_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_person_session
  end

  root "welcome#index"

  get 'families/new' => "family#new", as: "new_family"
  get "families/:id" => "family#show", as: "family"
  post 'families' => "family#create"

  get 'person/:id' => "person#show", as: 'person'

  get 'families/:id/albums' => "albums#index", as: 'albums'
  get 'families/:id/albums/new' => "albums#new", as: 'new_album'
  get 'families/:id/albums/:album_id/edit' => "albums#edit", as: 'edit_album'
  get 'families/:id/albums/:album_id' => "albums#show", as: 'album'
  
  post 'families/:id/albums' => "albums#create"
  patch 'families/:id/albums/:album_id' => "albums#update", as: "family_album"
  delete 'families/:id/albums/:album_id' => "albums#destroy", as: 'destroy_album'
  
  post 'families/:id/albums/:album_id/photos' => "photos#create", as: "create_photo"

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
