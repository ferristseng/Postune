Postune::Application.routes.draw do

  # Root
  root :to => "static_pages#css"

  # Main front-end routes
  namespace :user, :path => "/" do
    # User resources
    # File : users_controller.rb
    resources :users, :path => "/user", :except => [ :new ] do
      # Station resources
      # File : stations_controller
      resources :stations, :only => [ :update ]
      match ':slug', :to => 'stations#show', :as => "show_station", :id => /\w+/
      match ':slug/edit', :to => "stations#edit", :as => "edit_station", :id => /\w+/
      # Song list
      match ':slug/songs', :to => 'songs#index', :as => "songs_list"
    end

    resources :songs, :only => [ :create, :update, :destroy, :show ] do
      match '/search', :to => 'songs#search', :on => :collection
    end

    match 'register', :to => 'users#new'

    # Session resources
    # File : sessions_controller.rb
    resources :sessions, :only => [ :create ]
    match 'login', :to => 'sessions#new'
    match 'logout', :to => 'sessions#destroy'
  end

  # Static pages
  match '/css', :to => "static_pages#css"

  # Error pages

  match '/404', :to => "static_pages#error_404"
  match '/500', :to => "static_pages#error_500"

end
