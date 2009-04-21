ActionController::Routing::Routes.draw do |map|

  # See how all your routes lay out with "rake routes"

  map.resource :account, :controller => "users"
  map.resources :users
    
  map.resource :user_session
  map.resource :password_reset
  
  map.resource :areas
  map.find 'areas/find', :controller => 'areas', :action=>"find"
  
  
  map.root :controller => "user_sessions", :action => "new" # optional, this just sets the root route

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
end
