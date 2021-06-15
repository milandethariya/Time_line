class ActivationController < ApplicationController
  def new
  	@users = User.all
  end

  def update
  	@user = User.find(params[:id])
  	@user.update_attributes(is_activated: true,is_rejected: false)
  	redirect_to new_activation_path
  end

  def reject
  	@user = User.find(params[:id])
  	@user.update_attributes(is_rejected: true,is_activated: false)
  	redirect_to new_activation_path
  end

end
