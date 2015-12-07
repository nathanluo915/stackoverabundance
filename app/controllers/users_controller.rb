class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(permit_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = @user.errors.full_messages
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if logged_in? && current_user == @user
      render :edit
    else
      flash[:notice] = "Please log in"
      redirect_to login_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_params)
      redirect_to user_path(@user), success: "Profile updated"
    else
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end


  private

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end

  def update_params
    params.require(:user).permit(:username, :email, :password, :about, :website, :twitter, :github)
  end
end
