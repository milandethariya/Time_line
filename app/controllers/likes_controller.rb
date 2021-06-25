class LikesController < ApplicationController
  def likeshow
  	puts params[:id]
  	@micropost = Micropost.find_by(id: params[:id])
    like_user_id = @micropost.likes.where(is_like: true).pluck(:user_id)
    @users = User.where(id: like_user_id)
    respond_to do |format|
      format.js
    end
  end

  def unlikeshow
    puts params[:id]
    @micropost = Micropost.find_by(id: params[:id])
    unlike_user_id = @micropost.likes.where(is_like: false).pluck(:user_id)
    @users = User.where(id: unlike_user_id)
    respond_to do |format|
      format.js
    end
  end

  def like
    @micropost = Micropost.find_by(id: params[:id])
    if Like.where(user_id: current_user.id, micropost_id: @micropost.id).count == 1
      Like.where(user_id: current_user.id, micropost_id: @micropost.id).update(is_like: true)
    else
      current_user.likes.create(micropost_id: @micropost.id, is_like: true)
    end
    like_user_id = @micropost.likes.where(is_like: true).pluck(:user_id)
    @users = User.where(id: like_user_id)
    respond_to do |format|
      format.html{ redirect_to timeline_user_path(current_user)}
      format.js
    end
  end

  def unlike
    @micropost = Micropost.find_by(id: params[:id])
    if Like.where(user_id: current_user.id, micropost_id: @micropost.id).count == 1
      Like.where(user_id: current_user.id, micropost_id: @micropost.id).update(is_like: false)
    else
      current_user.likes.create(micropost_id: @micropost.id, is_like: false)
    end
    unlike_user_id = @micropost.likes.where(is_like: false).pluck(:user_id)
    @users = User.where(id: unlike_user_id)
    respond_to do |format|
      format.html{ redirect_to timeline_user_path(current_user)}
      format.js
    end
    
  end

end
