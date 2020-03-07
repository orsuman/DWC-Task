class BookCommentsController < ApplicationController

  #ログイン後に見ることができる
  before_action :authenticate_user!

	def create
        #非同期通信で使う為、インスタンス変数にする
        @book = Book.find(params[:book_id])
        #以下は.非同期通信のインスタンス変数で使わないから、ローカル変数にする
        comment = current_user.book_comments.new(book_comment_params)
        comment.book_id = @book.id
        comment.save
        #非同期通信でコメント投稿する際、2回目以降は以下のインスタンス変数を使う
        @comment =BookComment.new
    end
    def destroy
        @book = Book.find(params[:book_id])
        comment = BookComment.find(params[:id])
        @comment =BookComment.new
        comment.destroy
    end

    private
    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end
end
