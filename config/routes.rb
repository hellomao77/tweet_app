Rails.application.routes.draw do
  # topアクションへのルーティング
  get "/" => "home#top"
  # aboutアクションへのルーティング
  get "about" => "home#about"

  # indexアクションへのルーティング
  get "posts/index" => "posts#index"
  # newアクションへのルーティング
  get "posts/new" => "posts#new"
  # DBに変更を加えるルーティング
  post "posts/create" => "posts#create"

  # showアクションへのルーティング(idごとの投稿詳細ページ)
  get "posts/:id" => "posts#show"
  # editアクションへのルーティング(編集機能)
  get "posts/:id/edit" => "posts#edit"
  # DBに変更を加えるルーティング
  post "posts/:id/update" => "posts#update"
  # DBに変更を加えるルーティング
  post "posts/:id/destroy" => "posts#destroy"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
