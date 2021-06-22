class SessionsController < ApplicationController
  before_action :logged, only:[:new]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.is_activated == true
        log_in(user)
        if params[:session][:remember] == "1"
          remember(user)
        end
        if user.is_admin?
          redirect_to activation_index_path
        else
          redirect_to user_path(user.id)
        end
      else
        flash.now[:notice] = "#{user.name} is not activated by admin" 
        render 'new'
      end 

    else
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    cookies.delete(:token)
    session.delete(:user_id)
    redirect_to root_path
  end



  private
    def logged
      if !current_user.nil?
        redirect_to user_path(current_user)
      end
    end
end
