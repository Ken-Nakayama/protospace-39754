Rails.application.routes.draw do
  devise_for :users

  # Deviseによるログアウト用のルートを追加
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy]  # newとcreateアクションに対するルーティングを追加
  resources :prototypes do
    resources :comments, only: [:create]
  end

  resources :users, only: [:show]

  get 'prototypes/index'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "prototypes#index"
end
