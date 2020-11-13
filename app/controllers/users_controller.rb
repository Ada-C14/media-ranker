class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      # Existing user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      redirect_to root_path
      return
    else
      # New user
      new_user = User.create(username: username)
      if new_user
        flash[:success] = "Successfully created user #{new_user.username} with ID #{new_user.id}"
        redirect_to root_path
        return
      else
        # Save failed
        flash.now[:error] = "Failed to save user"
        render :login_form, status: :bad_request
        return
      end

    end
  end

  def current_user
    @user = User.find(session[:user_id])
    unless @user
      flash[:error] = "User with ID in your cookies not found. Try logging in again"
      redirect_to root_path
      return
    end
  end
end
