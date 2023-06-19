Rails.application.routes.draw do
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  namespace :admin do
    root to: "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :orders_details, only: [:update]
  end

  root to: "public/homes#top"
  get "/about" => "public/homes#about"
  resources :items, only: [:index, :show]
  resource :customers, only: [:show, :update] do
    get 'information/edit' => "customers#edit", on: :collection
    get 'leave', on: :collection
    patch 'withdrawal', on: :collection
  end
  resources :cart_items, only: [:index, :update, :destroy, :create] do
    delete 'destroy_all', on: :collection
  end
  resources :orders, only: [:new, :create, :index, :show] do
    post 'confirm', on: :collection
    get 'completion', on: :collection
  end
  resources :deliveries, only: [:index, :edit, :create, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
