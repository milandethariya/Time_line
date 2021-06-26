class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]
  before_action :log_in?, only: [:index, :show, :edit, :upadte, :destroy]
  before_action :edituser, only:[:edit]

  # GET /users or /users.json

  # GET /users/1 or /users/1.json
  def show
  end

  def timeline
    @micropost = current_user.microposts.build
    friends_id = current_user.friends_id
    @pagy, @microposts = pagy(Micropost.where(user_id: friends_id))
    @comment = Comment.new
  end

  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if params[:user][:password] == params[:user][:password_confirmation]
      respond_to do |format|
        if @user.save
          flash[:success] = "User was successfully created."
          format.html { redirect_to root_path }
          format.json { render :show, status: :created, location: @user }
        else
          flash.now[:notice] = "unprocessable_entity"
          format.html { render :new} 
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now[:danger] = "password & conform_password not match"
      render :new   
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if params[:user][:password] == params[:user][:password_confirmation]
      respond_to do |format|
        if @user.update(user_params)
          flash[:success] = "User was successfully updated."
          format.html { redirect_to @user, success: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          flash.now[:notice] = "unprocessable_entity"
          format.html { render :edit}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now[:danger] = "password & conform_password not match"
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, success: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthdate, :gender, :profile_image, :cover_image, :password, :conform_password,:activate)
    end

    def edituser
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end

end
