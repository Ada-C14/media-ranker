class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
    end
    
    redirect_to root_path
    return 
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    @votes = Vote.where(user_id: @current_user.id)
    unless @current_user
      flash[:error] = "A problem occurred: You must log in to do that"
      return
    end
  end

  def index
    @users = User.all

  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
      return
    end

    @votes = Vote.where(user_id: @user.id)
  end

end
