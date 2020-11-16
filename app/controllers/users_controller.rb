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
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{username}!"
    else
      @user = User.create(username: username)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome, #{username}! You'll love it here!"
      else
        flash[:error] = "Error! Username can't be left blank"
        redirect_to login_path
        return
      end
    end
    redirect_to root_path
  end

  def logout
    @user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:success] = "See you later, #{@user.username}!"
    redirect_to root_path
    return
  end

  # dont forget this
end
