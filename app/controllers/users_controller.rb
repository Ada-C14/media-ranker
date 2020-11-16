class UsersController < ApplicationController

  before_action :require_login, only: [:show, :upvote]

  # Helper methods
  def successful_login
      flash[:success] = "Successfully created user."
  end

  def successful_logged
      flash[:success] = "Successfully logged in as existing user."
  end

  def could_not_log_in_error_notice
    flash[:notice] = "A problem occurred: Could not log in"
  end

  def authentication_notice
    flash[:notice] = "Please log in to perform this action"
  end

  def log_out
    flash[:success] = "Successfully logged out"
  end

  def must_be_logged
    flash[:error] = "A problem occurred: You must log in to do that"
  end

  #########################################################

  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
    if @user.nil?
      could_not_log_in_error_notice
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      user = User.new(username: params[:user][:username])
      if !user.save
        could_not_log_in_error_notice
        redirect_to login_path
        return
      end
      successful_login
    else
      successful_logged
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        log_out
      else
        session[:user_id] = nil
      end
    else
      authentication_notice
    end
    redirect_to root_path
  end

  def current
    unless @current_user
     must_be_logged
      redirect_to root_path
      return
    end
  end
end