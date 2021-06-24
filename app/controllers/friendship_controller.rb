class FriendshipController < ApplicationController
  def show
  	friends =  current_user.senders.where(status: "accept").pluck(:receiver_id)
  	friends += current_user.receivers.where(status: "accept").pluck(:sender_id)
  	@friends = User.where(id: friends)
  end

  def create
  	@friendship = current_user.senders.create(receiver_id: params[:id])
    @friendrequestuser = User.find_by(id: params[:id])
    respond_to do |format|
      format.html{ redirect_to users_path }
      format.js
    end
  end

  def receive
  	@receivers = current_user.receivers.where(status: "pending")
  end

  def update
  	friendship = Friendship.find_by(id: params[:id])
  	friendship.update(status: "accept")
    @receivers = current_user.receivers.where(status: "pending")
    respond_to do |format|
  	 format.html{redirect_to user_path(current_user)}
     format.js
    end
  end

  def destroy
  	friendship = Friendship.find_by(id: params[:id])
  	friendship.destroy
    @receivers = current_user.receivers.where(status: "pending")
  	respond_to do |format|
     format.html{redirect_to user_path(current_user)}
     format.js
    end
  end
end
