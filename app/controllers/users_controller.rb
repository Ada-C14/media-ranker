class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    if @user.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
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
        flash.now[:problem] = @user.errors
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
