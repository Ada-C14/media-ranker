class UsersController < ApplicationController
  def index
    @users = User.all # list all users in order
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      redirect_to users_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

  def login
    name = params[:name]
    @user = User.find_by(name: name)
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.name}"
    elsif
      @user = User.create(name: name)
      session[:user_id] = @user.id
      flash[:success] = "#{@user.name}, you have successfully logged in as new user"
    else
      flash.now[:error] = "Unable to log in"
      render :login_form
    end
    
    session[:user_id] = @user.id
    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
  
end

