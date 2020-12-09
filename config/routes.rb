Rails.application.routes.draw do
  scope module: :public do
    root 'home#home'
    resources :lists, only: [:index, :show, :create, :edit, :update, :destroy] 
    devise_for :end_users, controllers: {
      sessions: 'public/end_users/sessions',
      registrations: 'public/end_users/registrations'
    }
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
