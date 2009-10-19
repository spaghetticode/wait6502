ActionController::Routing::Routes.draw do |map|

  map.namespace(:admin) do |admin|
    admin.resources :countries, :users, :currencies, :manufacturers, :computer_types, :io_ports, :storage_names
  end
  
  map.resources :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :controller => 'admin/countries', :action => 'index'
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
