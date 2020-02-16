class Book < ApplicationRecord

    belongs_to :user

    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
    end

    validates :title, presence: true

    #感想文200文字以上がエラーなので、最大文字数を199文字と設定した。
    validates :body, presence: true, length: { maximum: 199 }

end
