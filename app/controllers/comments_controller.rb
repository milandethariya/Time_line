class CommentsController < ApplicationController
  before_action :set_micropost, only:[:show, :create]

  def show
    @comments = @micropost.comments
    respond_to do |format|
      format.js
    end
    #@comments_user_id = micropost.comments.pluck(:user_id)
  end

  def create
    @micropost.comments.create(user_id: current_user.id, comment: params[:comment][:comment] )
    @comment = Comment.new
    @comments = @micropost.comments
    respond_to do |format|
      format.html{ redirect_to timeline_user_path(current_user)}
      format.js
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    @micropost = comment.micropost
    @comments = @micropost.comments
    if comment.user.id == current_user.id || User.find_by(is_admin: true).id
      Comment.find_by(id: params[:id]).destroy
      flash.now[:success] = "comment deleted!"    
    end
    respond_to do |format|
      format.html{ redirect_to timeline_user_path(current_user) }
      format.js
    end
  end


  private

    def set_micropost
      @micropost = Micropost.find_by(id: params[:id])
    end
end
