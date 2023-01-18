class Post < ApplicationRecord
  # 投稿が存在していること、最大140文字以内が条件
  validates :content, {presence: true, length: {maximum: 140}}
end
