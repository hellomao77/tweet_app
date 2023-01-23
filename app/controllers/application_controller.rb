class ApplicationController < ActionController::Base

  # 全アクションで共通する処理を定義
  before_action :set_current_user

  def set_current_user
    # current_userにログイン中のidのユーザー情報を代入
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    # ログインしていないユーザーを禁止する
    # 同じクラスなので@current_userを使える
    if @current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    # ログインユーザーを禁止する
    if @current_user
      flash[:notice] = "ログイン済です"
      redirect_to("/posts/index")
    end
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
