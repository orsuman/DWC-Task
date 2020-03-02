class BookCommentsController < ApplicationController

  #ログイン後に見ることができる
  before_action :authenticate_user!

	def create
        book = Book.find(params[:book_id])
        comment = current_user.book_comments.new(book_comment_params)
        comment.book_id = book.id
        comment.save
        flash[:success] = 'You have created successfully.'
        redirect_to book_path(book)
    end
    def destroy
        comment = BookComment.find(params[:id])
        comment.destroy
        flash[:success] = 'You have destroyed successfully.'
        redirect_to books_path
    end
    private
    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end
end
