class MicropostsController < ApplicationController

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
      redirect_to user_path
		else
			 render '404'
		end
	end

	def destroy
		@micropost = current_user.microposts.find_by(id: params[:id])
		@micropost.destroy
		flash[:success] = "Micropost deleted!"
		redirect_to root_url	
	end

	private

	def micropost_params
		params.require(:micropost).permit(:content)
	end
end
