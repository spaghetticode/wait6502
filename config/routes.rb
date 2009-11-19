ActionController::Routing::Routes.draw do |map|
  associations = {}
  %w{cpu builtin_storage operative_system co_cpu io_port}.each do |model|
    associations["add_#{model}"] = :put
    associations["remove_#{model}"] = :delete
  end
  
  map.namespace(:admin) do |admin|
    admin.resource :resultset
    admin.resources :auctions, :member => {:set_final_price => :put}
    admin.resources( 
      :users, :manufacturers, :io_ports, :co_cpus,
      :cpus, :builtin_storages, :operative_systems
    )
    admin.resources(:hardware, 
      :member => associations,
      :has_many => [:original_prices, :images, :ebay_keywords]
    )
        
    admin.with_options  :except => [:show, :update, :edit] do |m|
      m.resources :countries
      m.resources :currencies
      m.resources :hardware_types
      m.resources :storage_names
    end
    
    admin.with_options(
      :except => [:show, :update, :edit, :destroy],
      :collection => { :delete => :delete }
    ) do |m|
      m.resources :storage_sizes
      m.resources :storage_formats
      m.resources :cpu_families
      m.resources :cpu_names
      m.resources :co_cpu_names
      m.resources :builtin_languages
    end    
  end
    
  map.with_options :only => [:index, :show] do |m|
    m.resources :computers, :as => 'old-computers'
    m.resources :peripherals
    m.resources :manufacturers
    m.resources :cpus, :as => 'cpu'
    m.resources :hardware_types, :as => 'categories'
    m.resources :io_ports
    m.resources :co_cpus, :as => 'co-cpu'
    m.resources :operative_systems
    m.resources :builtin_languages
    m.resources :builtin_storages
  end
  
  map.resources :user_sessions  
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.root :controller => 'computers', :action => 'index'
end
