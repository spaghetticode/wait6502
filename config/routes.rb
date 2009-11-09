ActionController::Routing::Routes.draw do |map|

  associations = {}
  %w{cpu builtin_storage operative_system co_cpu io_port}.each do |model|
    associations["add_#{model}"] = :put
    associations["remove_#{model}"] = :delete
  end
  
  map.namespace(:admin) do |admin|
    admin.resources :users, :manufacturers, :io_ports, :builtin_storages, :cpus, :co_cpus, :operative_systems
    admin.resources :hardware, :member => associations, :has_many => [:original_prices, :images, :ebay_keywords]
    
    admin.resources :auctions, :member => {:set_final_price => :put}
    admin.resources :countries,         :except => [:show, :update, :edit]
    admin.resources :currencies,        :except => [:show, :update, :edit]
    admin.resources :hardware_types,    :except => [:show, :update, :edit]
    
    admin.resources :storage_names,   :except => [:show, :update, :edit]
    admin.resources :storage_sizes,   :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :storage_formats, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :cpu_families, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :cpu_names,    :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    admin.resources :co_cpu_names, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resources :builtin_languages, :except => [:show, :update, :edit, :destroy], :collection => { :delete => :delete }
    
    admin.resource :resultset
  end
  
  map.resources :user_sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :controller => 'admin/countries', :action => 'index'
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
