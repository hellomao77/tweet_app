class Post < ApplicationRecord
  # 投稿が存在していること、最大140文字以内が条件
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}

  def user
    # Postモデルに投稿に基づいたユーザー情報を戻り値とするメソッドを定義
    # selfはインスタンス自身を指す
    return User.find_by(id: self.user_id)
  end
end
