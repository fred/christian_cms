ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  map.root :controller => "articles"
  
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  map.connect '/article/:permalink', :controller => 'articles', :action => 'show'
  map.permalink '/article/:permalink', :controller => 'articles', :action => 'show'
  
  map.register '/register', :controller => 'users', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.resources :menu_items
  map.resources :news
  map.resources :articles, :collection => { :search => :get}, :member => {:rate => :post, :tags => :get}
  map.resources :buletins
  map.resources :events
  map.resources :birthdays
  map.resources :settings
  map.resources :users
  map.resources :comments
  map.resource :session
  map.resources :messages, :collection => {:thank_you => :any, :moved_permanently => :any}


  map.connect 'articles/tags/:tag', :controller => 'articles', :action => 'tags'
  
  # allow neat permalinked urls
  map.connect 'articles/page/:page',
    :controller => 'articles', :action => 'index',
    :page => /\d+/
    
  # Date options i.e.: /2008/02/24/
  date_options = { :year => /\d{4}/, :month => /(?:0?[1-9]|1[12])/, :day => /\d{1,2}/ }

  map.with_options(:conditions => {:method => :get}) do |get|
    get.with_options(date_options.merge(:controller => 'articles')) do |dated|
      dated.with_options(:action => 'index') do |finder|
        # new URL
        finder.connect ':year/page/:page',
          :month => nil, :day => nil, :page => /\d+/
        finder.connect ':year/:month/page/:page',
          :day => nil, :page => /\d+/
        finder.connect ':year/:month/:day/page/:page', 
          :page => /\d+/
        finder.connect ':year',
          :month => nil, :day => nil
        finder.connect ':year/:month',
          :day => nil
        finder.connect ':year/:month/:day', 
          :page => nil
      end
      dated.with_options(:action => 'show') do |finder|
        finder.connect ':year/:month/:day/:permalink'
      end
    end
  end
  map.with_options :controller => 'sessions' do |session|
    session.login    'login',  :action => 'new'
    session.logout   'logout', :action => 'destroy'
  end
  
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
   
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }
  
  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  map.namespace :admin do |admin|
    # Directs /admin/articles/* to Admin::ArticlesController (app/controllers/admin/articles_controller.rb)
    admin.resources :users
    admin.resources :settings
    admin.resources :articles
    admin.resources :menu_items
    admin.resources :birthdays
    admin.resources :buletins
    admin.resources :news
    admin.resources :events
    admin.resources :messages
    admin.resources :comments
    admin.resources :users
  end
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  
  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  map.connect "/admin", :controller => "admin/dashboard"
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "articles"
  
  # for mobile devices  
  map.connect "/mobile/:controller/:action/:id", :for_mobile => true
  map.connect '/mobile/:controller/:action/:id.:format', :for_mobile => true
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  # Non existing URL, send a "301 Moved Permanently"
  #map.connect '*path', :controller => "articles", :action => "moved_permanently"
end
