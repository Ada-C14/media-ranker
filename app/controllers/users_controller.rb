# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, except: [:current_user] # Unsure how to use this!

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
    nil
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = 'You must be logged in to see this page'
      redirect_to root_path
      nil
    end
  end

  def logout
    # Which line of code from the bottom 2 should I use to define the "current user ID"
    # user = User.create(username: username)
    # @current_user = User.find_by(id: session[:user_id])
    session[:current_user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_path
  end
end
