class UsersController < ApplicationController

  before_action :ensure_correct_user, only:[:create, :update, :destroy]

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
      # Redirect here will lose @user - you maybe should render :new 
      # if you want the user to have access to the errors
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    #I would handle these two cases separately (or use the before_action)
=begin    
    if logged_in
      if current_user == @user
        render :edit
      else
        redirect_to edit_user_path current_user
      end
    else
      redirect_to login_path
    end
=end

    if logged_in? && current_user == @user
      render :edit
    else
      flash[:notice] = "Please log in"
      redirect_to login_path
    end
  end

  def update
    # What's stopping me updating someone else here? I can change the id 
    # in the form action in developer tools. You need to stop me.
    @user = User.find(params[:id])
    if @user.update_attributes(update_params)
      redirect_to user_path(@user), success: "Profile updated"
    else
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to root_path
  end


  private

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end

  def update_params
    params.require(:user).permit(:username, :email, :password, :about, :website, :twitter, :github)
  end

  def ensure_correct_user
    target = User.find_by(id: params[:id])
    redirect_to root_path unless target == current_user
  end
end
