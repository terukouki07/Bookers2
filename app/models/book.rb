class Book < ApplicationRecord
  # ActiveStorage
  has_one_attached :profile_image

  #userモデルのアソシエーション
  belongs_to :user

  #バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
