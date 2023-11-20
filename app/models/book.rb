class Book < ApplicationRecord
  # ActiveStorage
  has_one_attached :image

  #userモデルのアソシエーション
  belongs_to :user
end
