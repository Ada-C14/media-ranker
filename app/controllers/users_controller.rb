class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:message] = "Successfully logged in as existing user #{user.username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:message] = "Successfully created new user #{user.username} with #{user.id}"
    end

    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

end