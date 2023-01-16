Rails.application.routes.draw do
  
  # topアクションへのルーティング
  get "/" => "home#top"
  # aboutアクションへのルーティング
  get "/about" => "home#about"

  # indexアクションへのルーティング
  get 'posts/index' => "posts#index"
  # newアクションへのルーティング
  get "posts/new" => "posts#new"
  # showアクションへのルーティング(投稿詳細ページ)
  get "posts/:id" => "posts#show"

  # DBに変更を加えるルーティング
  post "posts/create" => "posts#create"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
