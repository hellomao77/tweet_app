class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

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
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_icon.jpg",
      password: params[:password]
    )

    if @user.save
      # 新期登録時にそのままログインするようsession代入
      session[:user_id] = @user.id
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

  def login_form

  end

  def login
    # フォームで入力されたemailとpasswordからユーザーを探し@userに代入
    @user = User.find_by(email: params[:email], password: params[:password])

    if @user
      # session:ページを移動してもユーザー情報を保持し続ける(ここでは@user.id)
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      # エラーログを自作する
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render "users/login_form", status: :unprocessable_entity
    end
  end

  def logout
    # nilを代入することでログイン状態ではなくなる
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    # 正しいユーザーかを確かめる
    # params[:id]は文字列型なので変換する
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
