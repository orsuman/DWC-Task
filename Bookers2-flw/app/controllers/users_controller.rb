class UsersController < ApplicationController

  #ログイン後に見ることができる
  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]

  def index
      @users = User.all
      @book = Book.new
      @user = current_user
  end

  def show
  	  @user = User.find(params[:id])
      @books = @user.books.page(params[:page]).reverse_order
      @bookn = Book.new
  end

  def edit
  	  @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
      else
         render 'edit'
      end
  end

  def create
      @user = User.new(user_params)
      @user.save
      flash[:success] = 'You have created user successfully.'
      redirect_to @user
  end

  def following
    @title = "Following Users"
    @user  = User.find(params[:id])
    @users = @user.following_user
    render 'show_follow'
  end

  def followers
    @title = "Followers Users"
    @user  = User.find(params[:id])
    @users = @user.followers_user
    render 'show_follow'
  end

  private
  def user_params
  	  params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user.id)
    end
  end

end