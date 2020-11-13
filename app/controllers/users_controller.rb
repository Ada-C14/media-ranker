class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:error] = "Sorry, no such user found"
      redirect_to root_path and return
    end
  end

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

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must log in to see this page"
      redirect_to root_path and return
    end
  end
end
