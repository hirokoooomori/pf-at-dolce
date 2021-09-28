Rails.application.routes.draw do


  devise_for :customers, controllers: { registrations: 'customers/registrations', sessions: 'customers/sessions' }
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  namespace :admin do
    get 'homes/top' => 'homes#top'


    resources :shops do
      resources :products
    end
    resources :customers
    resources :genres
    resources :areas
    resources :atmospheres
    resources :scores
    resources :comments
    resources :contacts do
      resources :faqs
    end
  end

  resources :admin, only: [:index, :new, :create, :show] do
    collection do
      post :confirm
    end
  end

  devise_scope :admin do
    get '/admins/sign_in' => 'admins/sessions#new'
    post '/admins/sign_in' => 'admins/sessions#create'
    delete '/admins/sign_out' => 'admins/sessions#destroy'
  end


  scope module: :public do
    get 'homes/top'
    post 'homes/top' => 'homes#top'
    root to: 'homes#top'
    resources :products
    resources :genres
    resources :areas
    resources :atmospheres
    get 'search' => 'search#search'
    resources :scores
    resources :faqs


    resources :contacts, only: [:new, :create]
    post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
    post 'contacts/back', to: 'contacts#back', as: 'back'
    get 'done', to: 'contacts#done', as: 'done'

    resources :shops do
      resources :reviews, only: [:index, :create]
      resources :comments
      resources :favorites, only: [:create, :destroy]
      resources :candidates, only: [:create, :destroy]
    end

    resources :customers, only: [:show, :edit, :quit, :update, :destroy]




  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
