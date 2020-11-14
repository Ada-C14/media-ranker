class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(user_params)

    if @user.nil?
      @user = User.new(user_params)
      @user.save
      flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
    elsif @user
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
    else
      flash.now[:warning] = "Something went wrong 😱...let's try again 😊:"
      render :login_form
      return
    end

    session[:user_id] = @user.id
    redirect_to root_path
    return
  end

  def logout
    user_session = session[:user_id]
    @user = User.find_by(id: user_session)
    user_session = nil
    flash[:success] = "Successfully logged out #{@user.username}"
    redirect_to root_path
    return
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end
  end
end

def user_params
  return params.require(:user).permit(:username)
end