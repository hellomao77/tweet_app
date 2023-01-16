class PostsController < ApplicationController
  def index
    # 作成日時降順に表示させる
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    # params[:id]であるidの投稿データを取得して@postに保存
    @post = Post.find_by(id:params[:id])
  end

  def new
    
  end

  def create
    # 投稿フォームから送信されたデータを受け取り保存する
    @post = Post.new(content: params[:content])
    @post.save
    # 自動的に投稿一覧ページに転送させる
    redirect_to("/posts/index")
  end
end
