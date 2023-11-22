class Book < ApplicationRecord
  # ActiveStorage
  has_one_attached :profile_image

  #userモデルのアソシエーション
  belongs_to :user

end
