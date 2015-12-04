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
      render :new
    end
  end

  def show
    user_id = current_user.id
    @user = User.find(user_id)

  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end
end