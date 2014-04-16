Rails.application.routes.draw do

  as :person do
    get 'login' => 'devise/sessions#new', :as => :new_person_session
    
    post 'logout' => 'devise/sessions#create', :as => :person_session
    
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_person_session
    
    patch '/person/confirmation' => 'confirmations#update', :via => :patch, :as => :update_person_confirmation
  end
  
  devise_for :people, :skip => [:sessions], :controllers => {:registrations => "registrations", :confirmations => "confirmations"}

  root "welcome#index"

  # for permissions
 
  get "/permissions/:id/group" => "permissions#group", as: "group_permissions"
  get "/permissions/:id/individual" => "permissions#individual", as: "individual_permissions"
  
  # family routes

  get 'families/new' => "family#new", as: "new_family"

  get 'families/add_member' => "family#add_member_input", as: "add_member"
  
  get 'families/:id/about_us' => "family#about_us", as: "about_us"

  get "families/:id" => "family#show", as: "family"
  
  post 'families' => "family#create"

  # album routes

  get 'families/:id/albums' => "albums#index", as: 'albums'
  
  get 'families/:id/albums/new' => "albums#new", as: 'new_family_album'

  get 'families/:id/albums/:album_id' => "albums#show", as: 'album'

  post 'families/:id/albums' => "albums#create", as: "family_albums"

  patch 'families/:id/albums/:album_id' => "albums#update", as: "update_family_albums"
  
  delete 'families/:id/albums/:album_id' => "albums#destroy", as: 'delete_family_album'
  
  # photo routes

  post 'families/:id/albums/:album_id/photos' => "photos#create", as: "family_album_photo"
  
  delete 'families/:id/albums/:album_id/photos/:photo_id' => "photos#destroy", as: "delete_family_album_photo"

  # conversations routes

  get "/families/:id/conversations" => "conversations#index", as: "conversations"

  get "/families/:id/conversations/:conversation_id" => "conversations#show", as: "family_conversation"

  post "/families/:id/conversations" => "conversations#create", as: "family_conversations"

  delete "/families/:id/conversations/:conversation_id" => "conversations#destroy", as: "delete_family_conversations"

  # message routes

  post "/families/:id/conversations/:conversation_id/messages" => "messages#create", as: "family_conversation_messages"

  delete "/families/:id/conversations/:conversation_id/messages/:message_id" => "messages#destroy", as: "delete_family_conversation_message"

  # events routes

  get "/families/:id/events" => "events#index", as: "family_events" 

  get "/families/:id/events/new" => "events#new", as: "new_event"  
  
  get "/families/:id/events/:event_id" => "events#show", as: "event"  
  
  post "/families/:id/events" => "events#create", as: "person_events"
  
  delete "/families/:id/events/:event_id" => "events#destroy", as: "delete_family_event"

end