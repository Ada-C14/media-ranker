class UsersController < ApplicationController

  def index
    @user = User.all
  end
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)

    if @user.nil?
      @user = User.new(username: username)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{username} with ID #{@user.id}"
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        render :login_form, status: :bad_request
        return
      end
    else
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{username}"
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"

    redirect_to root_path
  end
end
