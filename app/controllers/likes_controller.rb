class LikesController < ApplicationController
  before_action :set_micropost
  def likeshow
    like_user_ids = @micropost.likes.where(is_like: true).pluck(:user_id)
    @users = User.where(id: like_user_ids)
    respond_to do |format|
      format.js
    end
  end

  def unlikeshow
    unlike_user_ids = @micropost.likes.where(is_like: false).pluck(:user_id)
    @users = User.where(id: unlike_user_ids)
    respond_to do |format|
      format.js
    end
  end

  def like
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

  private 
    def set_micropost
      @micropost = Micropost.find_by(id: params[:id])
    end
end
