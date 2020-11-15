class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    found_user = User.find_by(username: username)

    if found_user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
      # flash[:felicia] = "Girl, bye"
      # flash[:warning] = "Thou must go"
    else
      new_user = User.create(username: username)
      session[:user_id] = new_user.id
      flash[:success] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
    end

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
