class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book


  attachment :profile_image

  #名前は空白ダメ、他ユーザーと重複ダメ、２文字以上２０文字までと設定した。
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }

  #自己紹介文は最大５０文字とした。
  validates :introduction, length: { maximum: 50 }

end
