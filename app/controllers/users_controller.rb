class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    #TODO - name being set to empty string after 2nd click of log in button

    # name = params[:user] ? params[:user][:name] : params[:name]
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{name}"
      redirect_to root_path
      return
    elsif User.new(name: name).valid?
      user = User.create(name: name)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{name}"
      redirect_to root_path
      return
    else
      flash.now[:warning] = "A problem occurred: Could not log in"
      render :login_form, status: :bad_request
      return
    end
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
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end
end
