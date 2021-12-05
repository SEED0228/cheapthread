Rails.application.routes.draw do
  scope module: :public do
    devise_for :end_users, controllers: {
      sessions: 'public/end_users/sessions',
      registrations: 'public/end_users/registrations'
    }
    root 'home#home'
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :lists, only: [:show, :create, :edit, :update, :destroy] do 
      resources :list_elements, only: [:new, :create, :update, :destroy]
      get 'gacha/default', to: 'gachas#default', as: :gacha_default
      get 'gacha/price', to: 'gachas#price', as: :gacha_price
      get 'gacha/calorie', to: 'gachas#calorie', as: :gacha_calorie
      post 'gacha/default', to: 'gachas#default_create', as: :gacha_default_create
      post 'gacha/price', to: 'gachas#price_create', as: :gacha_price_create
      post 'gacha/calorie', to: 'gachas#calorie_create', as: :gacha_calorie_create
    end
    post 'home/sort', to: 'home#sort', as: :home_sort
    post 'lists/search', to: 'lists#search', as: :search_list
  end

  namespace :admin do
    devise_for :admins,
    path: '', controllers: {
      sessions: 'admin/admins/sessions'
    }
    get '/' => 'home#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :lists, only: [:index, :show] do
        resources :list_elements, only: [:index], path: :elements
        get 'gacha/default', to: 'gachas#default'
        get 'gacha/price', to: 'gachas#price'
        get 'gacha/calorie', to: 'gachas#calorie'
      end
    end
  end
end
