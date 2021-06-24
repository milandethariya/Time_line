class CommentsController < ApplicationController
	def show
		micropost = Micropost.find_by(id: params[:id])
		@comments = micropost.comments
		#@comments_user_id = micropost.comments.pluck(:user_id)
	end

	def create
		@micropost = Micropost.find_by(id:params[:micropost_id])
		@micropost.comments.create(user_id: current_user.id, comment: params[:comment][:comment] )
		@comment = Comment.new
		respond_to do |format|
			format.html{ redirect_to timeline_user_path(current_user)}
			format.js
		end
	end

	def destroy
		comment = Comment.find_by(id: params[:id])
		if comment.user.id == current_user.id
			Comment.find_by(id: params[:id]).destroy
			redirect_to timeline_user_path(current_user)
		end
	end

end
