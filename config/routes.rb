ActionController::Routing::Routes.draw do |map|

  map.resources :news
  map.resources :bibles
  map.resources :apostols
  map.resources :bible_texts

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  # map.resources :products

  # Sample resource route with options:
  # map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  # map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "articles"
  
  map.home '', :controller => 'forums', :action => 'index'

  #From here, you will need to add the resource routes in config/routes.rb.  
  #map.resources :users
  #map.resource  :session
  #If you're on rails 1.2.3 you may need to specify the controller name for the session singular resource:
  
  map.resources :articles
  map.connect '/article/:permalink', :controller => 'articles', :action => 'show'
  map.permalink '/article/:permalink', :controller => 'articles', :action => 'show'
  
  #map.connect '/register', :controller => 'users', :action => 'signup'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.resources :buletins
  map.resources :events
  map.resources :books
  map.resources :birthdays
  map.resources :settings
  map.resource :session
  map.resources :users
          
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :requirements => { :method => :get }

  map.with_options :controller => 'sessions' do |session|
    session.login    'login',  :action => 'new'
    session.logout   'logout', :action => 'destroy'
  end

  #Also, add an observer to config/environment.rb if you chose the --include-activation option
  #config.active_record.observers = :user_observer # or whatever you named your model
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.connect '*path', :controller => "articles", :action => "old_action"
end
