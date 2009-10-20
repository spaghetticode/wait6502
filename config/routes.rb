ActionController::Routing::Routes.draw do |map|

  map.namespace(:admin) do |admin|
    admin.resources :users, :currencies, :manufacturers, :io_ports, :builtin_storages
    admin.resources :countries, :except => [:show, :update, :edit]
    admin.resources :computer_types, :except => [:show, :update, :edit]
    
    admin.resources :storage_names, :except => [:show, :update, :edit]
    admin.resources :storage_sizes, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :storage_formats, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :cpu_families, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
  end
  
  map.resources :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :controller => 'admin/countries', :action => 'index'
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
