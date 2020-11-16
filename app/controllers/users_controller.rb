class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to root_path and return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      # new user
      user = User.new(username: params[:user][:username])
      if user.save
        flash[:success] = "Successfully created new user #{user.username} with ID: #{user.id}"
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:error] = ["A problem occurred: Could not log in"]
        flash[:error] << user.errors
        redirect_back fallback_location: '/'

        # render login_form, status: :bad_request and return
      end
    else
      # existing user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      session[:user_id] = user.id
      redirect_to root_path
    end


  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      if user.nil?
        session[:user_id] = nil
        flash[:notice] = 'ERROR unknown user'
      else
        session[:user_id] = nil
        flash[:success] = 'Successfully logged out'
      end
    else
      flash[:error] = ['You must be logged in to log out']
      redirect_to root_path
      return
    end

    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
