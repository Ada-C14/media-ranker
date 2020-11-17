# frozen_string_literal: true
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = 'User not found'
      redirect_to root_path
      nil
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{user.username}"
    else
      user = User.new(user_params)
      if user.save
        flash[:success] = "Successfully logged in as new user #{user.username}"
      else
        flash.now[:error] = 'Unable to login'
        render :login_form
      end
    end

    redirect_to root_path
    nil
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      if user.nil?
        session[:user_id] = nil
        flash[:error] = 'Unknown user'
      else
        session[:user_id] = nil
        flash[:success] = "#{user.username} has been logged out"
      end
    else
      flash[:error] = 'You must be logged in to log out.'
    end

    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:username)
  end
end
