Vaope::Application.routes.draw do
  
  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'

  devise_for :users do
    get 'sign_in', :to => 'devise/sessions#new'
  end

  resources :authentications
  resources :users

  resources :places do
    member do
      get 'mapa'
    end
  end

  resources :areas do
    member do
      get 'feed'
      get 'mapa'
    end
  end

  resources :categories do
    member do
      get 'feed'
      get 'mapa'
    end
  end

  match '/local/:id' => 'places#show'
  match '/categoria/:id' => 'categories#show'
  match '/zona/:id' => 'areas#show'
  match '/locales/:area/:category' => 'places#get_by_area_and_category'

  match '/features' => 'home#features'
  match '/info' => 'home#info'

  root :to => 'home#index'
end
