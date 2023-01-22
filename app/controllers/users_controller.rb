class UsersController < ApplicationController
  def index
    # Userはgenerateしたモデル名
    @users = User.all.order(created_at: :desc)
  end

  def show
    # params[:id]であるidの投稿データを取得して@userに保存
    @user = User.find_by(id:params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # 投稿フォームから送信されたデータを受け取り保存する
    # デフォルト画像も設定しておく
    @user = User.new(name: params[:name], email: params[:email], image_name: "default_icon.jpg")
    if @user.save
      flash[:notice] = "ユーザー登録をしました"
      redirect_to("/users/index")
    else
      # 失敗時は別のアクションを経由せず新規登録viewに戻る
      # update action内の@postは引き続き使用できる
      # rails7.0ではunprocessable_entityを指定しないといけない
      render "users/new", status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    # 更新するデータをDBから取り出す
    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      # 画像ファイルを作成する
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "ユーザーデータを編集しました"
      redirect_to("/users/index")
    else
      render "users/edit", status: :unprocessable_entity
    end
  end
end
