class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path(@user.id)
      flash[:success] = "Welcome!"
      return
    else
      flash.now[:error] = "Uh Oh. Please try again."
      render :new, status: :bad_request
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      # new user
      user = User.new(username: params[:user][:username])
      if ! user.save
        flash[:error] = "Unable to login"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{user.username}"
    else
      # existing user
      flash[:welcome] = "Welcome back #{user.username}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "Please log in"
      redirect_to root_path
      return
    end
  end

  def logout
    if session[:user_id]
      user = User.find_by(id:session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{user.username}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to log out"
    end
    redirect_to root_path
    flash[:success] = "You have logged out!"
  end

  private

  def user_params
    return params.require(:user).permit(:user_name, :join_date)
  end
end
