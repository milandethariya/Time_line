module ApplicationHelper
	def log_in(user)
		session[:user_id] = user.id  
	end

	def remember(user)
		cookies.permanent.signed[:token] = user.id 
	end

	def current_user
  	if (user_id = session[:user_id])
  	@current_user ||= User.find_by(id: user_id)
  	elsif (user_id = cookies.signed[:token])
  		user = User.find_by(id: user_id)
    	@current_user = user
		end
	end 

	def logged_in?
    !current_user.nil?
  end

  def log_in?
    unless !current_user.nil?
      redirect_to root_path
    end
  end

  

end
