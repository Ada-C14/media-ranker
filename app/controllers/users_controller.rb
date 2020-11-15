class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id].to_i)
    redirect_to works_path and return if @user.nil?
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{name}"
    else
      user = User.new(name: name)

      save = user.save

      session[:user_id] = user.id

      if save
        flash[:success] = "Successfully logged in as new user #{name}"
      else
        flash[:error] = error_flash("A problem occurred: Could not login", user.errors)
        redirect_to request.referrer and return
      end
    end

    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end



end
