class User < ApplicationRecord
  # 存在すること(空欄でない)、重複がないことが条件
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}

  def posts
    # Userモデルにそのユーザーに紐付いた投稿全て取得し戻り値とするメソッドを定義する
    # find_byでは1件しか取得できない
    return Post.where(user_id: self.id)
  end
end
