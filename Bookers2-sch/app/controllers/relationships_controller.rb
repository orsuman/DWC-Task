class RelationshipsController < ApplicationController

  def create
        current_user.follow(params[:id])
        flash[:success] = 'You have follow successfully.'
        #元の画面に遷移する場合
        redirect_to request.referer
  end

  def destroy
        current_user.unfollow(params[:id])
        flash[:success] = 'You have unfollow successfully.'
        redirect_to request.referer
  end

  def follower
  end

  def followed
  end

end
