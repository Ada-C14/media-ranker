class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = find_by_id

    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])

    if @user.nil? # create new user
      @user = User.new(username: params[:user][:username])
      if !@user.save
        flash[:error] = "Login failed"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{@user.username}"
    else
      flash[:welcome] = "Welcome back #{@user.username}"
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      unless @user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{@user.username}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown user"
      end
    else
      flash[:error] = "You must be logged in to log out"
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to login_path
      return
    end
  end

  def find_by_id
    user_id = params[:id].to_i
    user = User.find_by(id: user_id)
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

end
