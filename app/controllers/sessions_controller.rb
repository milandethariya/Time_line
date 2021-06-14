class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		if user.activate == true
  			log_in(user)
  			if params[:session][:remember_me] == "1"
  				remember(user)
				end
				if user.admin?
					redirect_to new_activation_path
				else
					redirect_to user_path(user.id)
				end
  		else
  			flash[:notice] = "#{user.name} is not activated by admin" 
  			render 'new'
  		end 

		else
			flash[:notice] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		cookies.delete(:user_id)
		session.delete(:user_id)
		@current_user = nil
	end
end
