class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ActiveStorage（アクティブストレージを使うための記述とカラムを設定する。）
  has_one_attached :profile_image

  def get_profile_image(width, height)
    # profile_imageがあるかどうか（unlessない場合の意味）
    unless profile_image.attached?
      # 画像がなかった場合、()の中の画像を自動で表示
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      # 画像の種類を決めている(jpg,pngなど)
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # 画像があった場合はサイズを決めて終わり。
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #Bookモデルのアソシエーション
  has_many :books, dependent: :destroy

  # バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

end
