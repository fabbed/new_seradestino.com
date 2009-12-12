ActionController::Routing::Routes.draw do |map|
  map.signup   '/registrate', :controller => 'users',   :action => 'new'
  map.login    '/entrar',  :controller => 'sessions', :action => 'new'
  map.logout   '/cerrar-sesion', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil


  map.reglas  '/reglas-de-uso', :controller => 'pages', :action => 'reglas_de_uso'
  map.privacidad  '/politica-de-privacidad', :controller => 'pages', :action => 'politica_de_privacidad'
  
  map.my_account '/mi-cuenta', :controller => 'account/base', :action => 'show'
  
  map.resource :account, :collection => { :validate => :get } do |account|
    account.resource   :profile,  :controller => "account/profiles"
    account.resource   :avatar,   :controller => "account/avatars"
    account.resource   :stories,   :controller => "account/stories"    
  end



  map.resources :users

  map.resource :sessions

  map.resources :visitors
  map.resources :visitor_sessions

  map.resources :newsletter_registrations
  map.resources :suggestions

  map.resources :resources, :member => { :set_selected_country => :post }


  map.resources :stories, 
                :collection => { :destino => :get, :casualidad => :get, :to_moderate => :get, :new2 => :get},
                :member => { :rate => :post, :update_story_settings => :post}

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
