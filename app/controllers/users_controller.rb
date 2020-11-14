class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form # ???
    @user = User.new
  end

  def login
    @user = User.find_by(id: params[:id])
    if @user.nil?
      @user = User.new(username: params[:user][:username])
      if @user.save
        flash[:success] = "Welcome #{@user.username}! You'll love it here!"
        # redirect_to root_path
      else
        flash.now[:error] = "Hmm..something went wrong. You're username wasn't saved. Try again later!"
        # redirect_to login_path
      end
    else
      flash[:success] = "Welcome back #{@user.username}!"
    end
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout

  end

  def current_user

  end
end
