ActionController::Routing::Routes.draw do |map|
  map.with_options(:namespace => 'admin/') do |admin|
    admin.resources :countries
  end

  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
