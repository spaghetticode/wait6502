ActionController::Routing::Routes.draw do |map|

  routes = {}
  %w{cpu builtin_storage operative_system co_cpu io_port}.each do |model|
    routes["add_#{model}"] = :put
    routes["remove_#{model}"] = :delete
  end
  
  map.namespace(:admin) do |admin|
    admin.resources :users, :currencies, :manufacturers, :io_ports, :builtin_storages, :cpus, :co_cpus, :operative_systems, :peripherals
    admin.resources :computers, :member => routes
    
    admin.resources :countries,         :except => [:show, :update, :edit]
    admin.resources :computer_types,    :except => [:show, :update, :edit]
    admin.resources :peripheral_types,  :except => [:show, :update, :edit]
    
    admin.resources :storage_names,   :except => [:show, :update, :edit]
    admin.resources :storage_sizes,   :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :storage_formats, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :cpu_families, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :cpu_names,    :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :co_cpu_names, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :builtin_languages, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    
  end
  
  map.resources :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :controller => 'admin/countries', :action => 'index'
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
