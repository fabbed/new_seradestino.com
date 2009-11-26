ActionController::Routing::Routes.draw do |map|
  map.signup   '/registrarse', :controller => 'users',   :action => 'new'
  map.login    '/conectar',  :controller => 'session', :action => 'new'
  map.logout   '/cerrar', :controller => 'session', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil



  map.resources :users

  map.resource :session

  map.resources :visitors
  map.resources :visitor_sessions

  map.resources :newsletter_registrations
  map.resources :suggestions

  map.resources :resources, :member => { :set_selected_country => :post }


  map.resources :stories, 
                :collection => { :tops => :get, :flops => :get, :to_moderate => :get, :new2 => :get},
                :member => { :vote_top => :post, :vote_flop => :post }

  map.resources :categories
    
  map.resource :comments  

  map.terms      '/terminos-del-servicio', :controller => 'terminos', :action => 'terms'
  map.privacidad  '/politica-de-privacidad', :controller => 'terminos', :action => 'privacidad'


  # map.admin_kpis        "admin/kpis",         :controller => 'admin/kpis'
  # map.admin_stories     "admin/stories",      :controller => 'admin/stories'
  # map.admin_suggestions "admin/suggestions",  :controller => 'admin/suggestions'
  
  map.root :controller => 'stories'

  map.sitemap "/sitemap.xml", :controller => "sitemap", :action => "xml"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
