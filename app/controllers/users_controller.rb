class UsersController < ApplicationController

  skip_before_action :require_login, except: [:current_user]

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
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
    return
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{user.username}. You have successfully logged out."
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end

  # def index
  #   @users = User.all
  # end
  #
  # def show
  #   if @user.nil?
  #     head :not_found
  #     return
  #   end
  # end

end
