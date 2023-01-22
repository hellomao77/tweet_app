class User < ApplicationRecord
  # 存在すること(空欄でない)、重複がないことが条件
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
end
