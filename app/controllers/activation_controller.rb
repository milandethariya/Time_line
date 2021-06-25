class ActivationController < ApplicationController
  def index
  	@users = User.all
  end

  def approve
  	@user = User.find(params[:id])
  	@user.update_attributes(is_activated: true,is_rejected: false)
    @users = User.all
    respond_to do |format|
      flash.now[:notice] = "#{@user.name} is Approved !"
      format.html{redirect_to activation_index_path}
      format.js
    end
  end

  def reject
  	@user = User.find(params[:id])
  	@user.update_attributes(is_rejected: true,is_activated: false)
    @users = User.all
  	respond_to do |format|
      flash.now[:notice] = "#{@user.name} is Rejected !"
      format.html{redirect_to activation_index_path}
      format.js
    end
  end

  def approvelist
    @users = User.where(is_activated: true)
  end

  def rejectlist
    @users = User.where(is_rejected: true)
  end
end
