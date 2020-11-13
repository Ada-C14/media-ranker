class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      user = User.new(name: params[:user][:name])
      if ! user.save
        flash[:error] = "unable to login"
        redirect_to root_path
        return
      end
      #new user
      flash[:welcome] = "Welcome #{user.name}!"
    else
      #existing user
      flash[:welcome] = "Welcome back #{user.name}"
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye, #{user.name}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout."
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end


end
