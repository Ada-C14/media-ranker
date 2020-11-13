class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Welcome, new user #{user.username}"
    end

    redirect_to root_path and return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Goodbye, you are logged out"
    redirect_to root_path and return
  end

  def current_user

  end
end
