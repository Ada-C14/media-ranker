class UsersController < ApplicationController


  def login_form
    @user = User.new
  end

  def index
    @users = User.all
  end

  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
      # New User
      user = User.new(username: params[:user][:username])
      if ! user.save
        flash[:error] = "Unable to login"
        redirect_to homepage_path
        return
      end
      flash[:welcome] = "Successfully created new #{user.username} with ID #{user.id}"
    # Existing User
  else
    flash[:welcome] = "Successfully logged in as existing user #{user.username}"
    end
    session[:user_id] = user.id
    redirect_to homepage_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        flash[:notice] = "Successfully logged out"
        session[:user_id] = nil
        redirect_to homepage_path
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
      redirect_to homepage_path
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, status: :not_found
      return
    end
  end

private

def user_params
  return params.require(:user).permit(:username)
end
end