class UsersController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username:params[:user][:username])

    if user.nil?
      #new user
      user = User.new(username:params[:user][:username])
      if user.save
        flash[:welcome] = "Welcome #{user.username}"
      end
      #else what if the user doesnt save?
    else
      flash[:welcome] = "Welcome back #{user.username}"
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice]= "Goodbye #{user.username}"
      else
        session[:user_id] = nil
        flash[:notice] = "Unknown user error"
      end
    else
      flash[:notice] = "You must be logged in to logout"
    end
    redirect_to root_path
    end

  def show
    @user = User.find(id: params[:id])
    if user.nil?
      redirect_to root_path
      return
    end
  end
end
