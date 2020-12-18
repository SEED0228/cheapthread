Rails.application.routes.draw do
  scope module: :public do
    devise_for :end_users, controllers: {
      sessions: 'public/end_users/sessions',
      registrations: 'public/end_users/registrations'
    }
    root 'home#home'
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :lists, only: [:index, :show, :create, :edit, :update, :destroy] do 
      resources :list_elements, only: [:new, :create, :update, :destroy]
      get 'gachas/default', as: :gacha_default
      get 'gachas/price', as: :gacha_price
      get 'gachas/calorie', as: :gacha_calorie
      post 'gachas/default', to: 'gachas#default_create', as: :gacha_default_create
      post 'gachas/price', to: 'gachas#price_create', as: :gacha_price_create
      post 'gachas/calorie', to: 'gachas#calorie_create', as: :gacha_calorie_create
    end
  end

  namespace :admin do
    devise_for :admins,
    path: '', controllers: {
      sessions: 'admin/admins/sessions'
    }
    get '/' => 'home#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
