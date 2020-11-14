class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def current
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must log in to view this page."
      redirect_to login_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user.nil?
      flash["alert alert-warning"] = "A problem occurred: Could not log in"
      redirect_back(fallback_location: works_path)
    elsif user
      session[:user_id] = user.id
      flash["alert alert-success"] = "Successfully logged in as existing user #{user.name}"
      redirect_to root_path
    else
      user = User.create(name: name)
      session[:user_id] = user.id

      flash["alert alert-success"] = "Successfully created new user #{user.name} with ID #{user.id}"

      redirect_to root_path
    end
    return
  end

  def logout
    user = User.where(id: session[:user_id])
    flash[:success] = "Successfully logged out"
    session[:user_id] = nil
    redirect_to login_path
    return
  end
end