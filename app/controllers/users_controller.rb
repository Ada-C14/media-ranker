# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  def login_form
    @user = User.new
  end
  def index
    @users = User.all
  end
  def show
    if @user.nil?
      redirect_to root_path, status: :not_found
      return
    end
  end
  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
      user = User.create(username: params[:user][:username])
      unless user.save
        flash[:error] = "Login failed"
        redirect_to root_path
        return
      end
      flash[:success] = "Successfully logged in as new user #{user.username}"
    else
      flash[:success] = "Successfully logged in as returning user #{user.username}"
    end
      session[:user_id] = user.id
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
  def find_user
    @user = User.find_by(id: params[:id])
  end
end
