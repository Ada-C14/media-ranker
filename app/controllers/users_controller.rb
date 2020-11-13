class UsersController < ApplicationController

  def login_form
    @user = User.new
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

  end

private

def user_params
  return params.require(:user).permit(:username)
end
end