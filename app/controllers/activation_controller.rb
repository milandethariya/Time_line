class ActivationController < ApplicationController
  def new
  	@users = User.where(activate: nil)
  end

  def update
  	@user = User.find(params[:id])
  	@user.update_attributes(activate: "true")
  	redirect_to new_activation_path
  end

  def update1
  	@user = User.find(params[:id])
  	@user.update_attributes(activate: "false")
  	redirect_to new_activation_path
  end

end
