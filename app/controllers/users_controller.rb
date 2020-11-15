class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{name}."
    else
      user = User.new(name: name)
      user.save
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{name}."
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:warning] = "Successfully logged out."
    redirect_to root_path
  end

end
