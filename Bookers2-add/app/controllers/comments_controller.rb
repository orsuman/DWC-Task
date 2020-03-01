class CommentsController < ApplicationController

  #ログイン後に見ることができる
  before_action :authenticate_user!

	def create
        book = Book.find(params[:book_id])
        comment = current_user.comments.new(comment_params)
        comment.book_id = book.id
        comment.save
        redirect_to book_path(book)
    end
    def destroy
        book = Book.find(params[:book_id])
        comment = Comment.find(params[:id])
        comment.destroy
        flash[:success] = 'You have destroyed successfully.'
        redirect_to book_path(book)
    end

    private
    def comment_params
        params.require(:comment).permit(:comment)
    end
end
