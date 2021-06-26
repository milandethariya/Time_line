class FriendshipController < ApplicationController
  before_action :set_friendship, only: [:update, :destroy]
  def show
    friends_id = current_user.friends_id
  	@friends = User.where(id: friends_id)
  end

  def create
  	@friendship = current_user.senders.create(receiver_id: params[:id])
    @friendrequestuser = User.find_by(id: params[:id])
    flash.now[:notice] = "sent friendrequest to #{@friendrequestuser.name} !"
    respond_to do |format|
      format.html{ redirect_to users_path }
      format.js
    end
  end

  def receive
  	@receivers = current_user.receivers.where(status: "pending")
  end

  def update
  	@friendship.update(status: "accept")
    @receivers = current_user.receivers.where(status: "pending")
    flash.now[:notice] = "Now you and #{User.find(@friendship.sender_id).name} are friends !"
    respond_to do |format|
  	 format.html{redirect_to user_path(current_user)}
     format.js
    end
  end

  def destroy
  	@friendship.destroy
    @receivers = current_user.receivers.where(status: "pending")
  	respond_to do |format|
     format.html{redirect_to user_path(current_user)}
     format.js
    end
  end

  private

    def set_friendship
      @friendship = Friendship.find_by(id: params[:id])
    end
end
