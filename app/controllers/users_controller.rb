class UsersController < ApplicationController
  def index
  end

  def show
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    else
      user = User.create(name: name)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}"
    end

  redirect_to root_path
  return
  end

  def logout
    raise
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end
end
