ActionController::Routing::Routes.draw do |map|
  map.with_options(:namespace => 'admin/') do |admin|
    admin.resources :countries, :users
  end
  
  map.resource :user_session
  map.login 'login', :controller => 'user_session', :action => 'new'
  map.logout 'logout', :controller => 'user_session', :action => 'destroy'
  map.root :controller => 'countries', :action => 'index'
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
