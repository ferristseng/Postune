Postune::Application.routes.draw do

  # Root
  root :to => "user::stations#public_new"

  # Main front-end routes
  namespace :user, :path => "/" do
    # =============================
    # User resources
    # File : users_controller.rb
    # =============================
    resources :users, :path => "/u", :except => [ :new ], :constraints => { :id => /[a-zA-Z0-9\.\-\_]+/ } do
      put 'reset', :to => 'reset_tokens#reset'
      get 'edit/password', :to => 'users#edit_password'
      put 'update/password', :to => 'users#update_password'
    end
    match 'register', :to => 'users#new'

    # =============================
    # Station Resources
    # File : stations_controller.rb
    # =============================
    resources :stations, :path => "/s", :constraints => { :id => /[\w!@#$\%^&*()\[\]{}:;<>?.,-~]+/ } do
      post 'p/create', :to => 'stations#public_create', :on => :collection
      post '/favorite', :to => "favorites#create"
      
      # =============================
      # Songs Resources
      # File : songs_controller.rb
      # =============================
      resources :songs, :only => [ :create ] do
        match '/search', :to => 'songs#search', :on => :collection
      end
    end

    # =============================
    # Session resources
    # File : sessions_controller.rb
    # =============================
    resources :sessions, :only => [ :create ]
    match 'login', :to => 'sessions#new'
    match 'logout', :to => 'sessions#destroy'
    match 'auth/:provider/callback', :to => 'sessions#create'

    # =============================
    # Reset Token resources
    # File : reset_tokens_controller.rb
    # =============================
    resources :reset_tokens, :only => [ :create ]
    match 'reset', :to => 'reset_tokens#new'

  end

  # =============================
  # Static pages
  # =============================
  match '/faq', :to => "static_pages#faq"
  match '/contact', :to => "static_pages#contact"
  match '/rules', :to => "static_pages#rules"

  # =============================
  # Error pages
  # =============================
  match '/404', :to => "static_pages#error_404"
  match '/500', :to => "static_pages#error_500"

end
