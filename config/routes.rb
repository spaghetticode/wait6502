ActionController::Routing::Routes.draw do |map|

  map.namespace(:admin) do |admin|
    admin.resources :users, :currencies, :manufacturers, :io_ports, :builtin_storages, :cpus, :co_cpus, :operative_systems
    admin.resources :computers, :member => { :add_cpu => :put, :remove_cpu => :delete, :add_builtin_storage => :put, :remove_builtin_storage => :delete, :add_operative_system => :put, :remove_operative_system => :delete, :add_co_cpu => :put, :remove_co_cpu => :delete}
    
    admin.resources :countries,      :except => [:show, :update, :edit]
    admin.resources :computer_types, :except => [:show, :update, :edit]
    
    admin.resources :storage_names,   :except => [:show, :update, :edit]
    admin.resources :storage_sizes,   :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :storage_formats, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :cpu_families,  :except => [:show, :update, :edit, :destroy],    :collection => { :delete => :delete }
    admin.resources :cpu_names,     :except => [:show, :update, :edit, :destroy],    :collection => { :delete => :delete }
    
    admin.resources :builtin_languages, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :co_cpu_names, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
  end
  
  map.resources :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :controller => 'admin/countries', :action => 'index'
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
