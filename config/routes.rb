ActionController::Routing::Routes.draw do |map|

  map.root :controller => "articles"

  map.connect '/article/:permalink', :controller => 'articles', :action => 'show'
  map.permalink '/article/:permalink', :controller => 'articles', :action => 'show'
  
  map.register '/register', :controller => 'users', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.resources :menu_items
  map.resources :news
  map.resources :articles, :collection => { :search => :get }
  map.resources :buletins
  map.resources :events
  map.resources :birthdays
  map.resources :settings
  map.resources :users
  map.resource :session
  map.resources :messages, :collection => {:thank_you => :any, :moved_permanently => :any}

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
  
  map.namespace :admin do |admin|
    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
    admin.resources :users
    admin.resources :settings
    admin.resources :articles
    admin.resources :menu_items
    admin.resources :birthdays
    admin.resources :buletins
    admin.resources :news
    admin.resources :events
  end

  map.connect "/admin", :controller => "admin/articles"
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "articles"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  # Non existing URL, send a "301 Moved Permanently"
  #map.connect '*path', :controller => "articles", :action => "moved_permanently"
end
