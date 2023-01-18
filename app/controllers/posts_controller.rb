class PostsController < ApplicationController
  # 全てのアクションのページが存在するわけでない
  
  def index
    # 作成日時降順に表示させる
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    # params[:id]であるidの投稿データを取得して@postに保存
    @post = Post.find_by(id:params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # 投稿フォームから送信されたデータを受け取り保存する
    @post = Post.new(content: params[:content])
    @post.save
    if @post.save
      # 成功時のメッセージをflashで表示する
      flash[:notice] = "新規投稿をしました"
      # 成功時は自動的に投稿一覧ページに転送させる
      redirect_to("/posts/index")
    else
      # 失敗時は別のアクションを経由せず投稿編集viewに飛ぶ
      # update action内の@postは引き続き使用できる
      # rails7.0ではunprocessable_entityを指定しないといけない
      render "posts/new", status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    # 更新するデータをDBから取り出す
    @post = Post.find_by(id:params[:id])
    # contentだけ更新する
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render "posts/edit", status: :unprocessable_entity
    end
  end

  def destroy
    # 更新するデータをDBから取り出す
    @post = Post.find_by(id: params[:id])
    # 投稿を削除
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    # 自動的に投稿一覧ページに転送させる
    redirect_to("/posts/index")
  end
end
