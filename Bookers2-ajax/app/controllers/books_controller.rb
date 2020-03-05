class BooksController < ApplicationController

  #ログイン後に見ることができる
  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

	def index
        #@bookにページングを設定した。
        @books = Book.page(params[:page]).reverse_order
        @book = Book.new
        @user = current_user
	end

	def create
  	    @book = Book.new(book_params)
  	    #validates:User must exist
  	    @book.user_id = current_user.id
  	      if @book.save
             flash[:success] = 'You have created book successfully.'
             redirect_to book_path(@book)
          else
             @books = Book.page(params[:page]).reverse_order
             @user = current_user
             render 'index'
          end
	end

	  def show
		    @book = Book.find(params[:id])
        @bookn = Book.new
        @user = current_user
        @comment = BookComment.new
	  end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
          if @book.update(book_params)
             flash[:success] = 'You have updated book successfully.'
             redirect_to book_path(@book)
          else
             render 'edit'
          end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        flash[:success] = 'You have destroyed successfully.'
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end

    #投稿者が、他ユーザーによって自分の本の編集ページに飛ぶのを許可しない
    def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

end