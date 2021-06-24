class MicropostsController < ApplicationController

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash.now[:success] = "Micropost created!"     
    else
      flash.now[:danger] = 'micropost have 1 to 140 characters!'
    end
    respond_to do |format|
      format.html{redirect_to timeline_user_path(current_user)}
      format.js{
        friends =  current_user.senders.where(status: "accept").pluck(:receiver_id)
        friends += current_user.receivers.where(status: "accept").pluck(:sender_id)
        friends.push(current_user.id)
        @microposts = Micropost.where(user_id: friends)
        @comment = Comment.new
        @micropost = Micropost.new
      }
    end
    #redirect_to request.referrer
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    @micropost.destroy
    flash.now[:success] = "Micropost deleted!"
    respond_to do |format|
    format.html{redirect_to timeline_user_path(current_user)}
    format.js{
      friends =  current_user.senders.where(status: "accept").pluck(:receiver_id)
      friends += current_user.receivers.where(status: "accept").pluck(:sender_id)
      friends.push(current_user.id)
      @microposts = Micropost.where(user_id: friends)
      @comment = Comment.new
    }
    end 
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :micropost_image)
  end
end
