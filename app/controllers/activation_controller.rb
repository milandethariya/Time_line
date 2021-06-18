class ActivationController < ApplicationController
  def index
  	@users = User.all
  end

  def approve
  	@user = User.find(params[:id])
  	@user.update_attributes(is_activated: true,is_rejected: false)
  	redirect_to activation_index_path
  end

  def reject
  	@user = User.find(params[:id])
  	@user.update_attributes(is_rejected: true,is_activated: false)
  	redirect_to activation_index_path
  end

  def approvelist
    @users = User.where(is_activated: true)
  end

  def rejectlist
    @users = User.where(is_rejected: true)
  end
end
