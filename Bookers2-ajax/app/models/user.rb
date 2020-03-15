class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :books, dependent: :destroy

  has_many :book_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

   # ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_user.include?(user)
end

  attachment :profile_image

  #名前は空白ダメ、他ユーザーと重複ダメ、２文字以上２０文字までと設定した。
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }

  #自己紹介文は最大５０文字とした。
  validates :introduction, length: { maximum: 50 }

end
