class MicropostsController < ApplicationController

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"     
    else
      flash[:danger] = 'micropost have 1 to 140 characters!'
		end
		redirect_to user_path(current_user)
	end

	def destroy
		@micropost = current_user.microposts.find_by(id: params[:id])
		@micropost.destroy
		flash[:success] = "Micropost deleted!"
		redirect_to user_path(current_user)	
	end

	private

	def micropost_params
		params.require(:micropost).permit(:content, :micropost_image)
	end
end
