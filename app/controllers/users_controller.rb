class UsersController < ApplicationController

  # skip_before_action :require_login, except: [:current_user]

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
    end

    redirect_to root_path
    return
  end

  def current
    # find out who current user is
    @current_user = User.find_by(id: session[:user_id])

    # to view current page, user needs to be logged in
    unless @current_user
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end
end
