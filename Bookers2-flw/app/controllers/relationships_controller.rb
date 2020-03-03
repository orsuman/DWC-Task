class RelationshipsController < ApplicationController

  def follow
        current_user.follow(params[:id])
        #元の画面に遷移する場合
        redirect_to request.referer
  end

  def unfollow
        current_user.unfollow(params[:id])
        redirect_to request.referer
  end

  def follower
  end

  def followed
  end

end
