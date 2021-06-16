class LikesController < ApplicationController
  def show
  	puts params[:id]
  	micropost = Micropost.find_by(id: params[:id])
  	@users = micropost.users
  	print @users
  end

  def create
  	micropost = Micropost.find_by(id:params[:micropost_id])
  	current_user.likes.create(micropost_id: micropost.id)
  	redirect_to user_path(current_user)
  end

  def destroy
  	micropost = Micropost.find_by(id: params[:micropost_id])
		micropost.likes.find_by(user_id: current_user.id).destroy
		redirect_to user_path(current_user)
  end
end
