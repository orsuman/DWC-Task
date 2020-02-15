class Book < ApplicationRecord

    belongs_to :user

    has_many :comments, dependent: :destroy

    validates :title, presence: true

    #感想文200文字以上がエラーなので、最大文字数を199文字と設定した。
    validates :body, presence: true, length: { maximum: 199 }

end
