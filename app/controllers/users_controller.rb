class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:user][:username])

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

  def logout
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out"
    redirect_to root_path
    return
  end


  # when no one is currently logged in
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end
end
