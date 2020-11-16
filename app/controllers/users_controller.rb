# frozen_string_literal: true

class UsersController < ApplicationController
  # skip_before_action :require_login, except: [:current_user]
  # before_action :find_user, only: [:show]
  def login_form
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path, status: :not_found
      return
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      return
    else
      flash.now[:error] = "Error occurred. User did not save. Please try again."
      render :login_form, status: :bad_request
      return
    end
  end

  def login
    user = User.find_by(username: params[:user][:username])
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
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:success] = "Successfully logged out"
        redirect_to root_path
      end
    else
      flash[:error] = "#{username} cannot be logged out. Login first!"
      redirect_to root_path
    end
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
