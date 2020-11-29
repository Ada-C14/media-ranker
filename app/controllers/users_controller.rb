class UsersController < ApplicationController
  before_action :require_login, only: [:logout]

  def index
    @users = User.all # list all users in order
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      redirect_to users_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(user_params)
    # Check if an user is already existed
    if user.nil?
      # New User
      user = User.new(user_params)
      if !user.save # can't save
        flash.now[:error] = "Unable to log in"
        @user = User.new
        render :login_form
        return
      end
      flash[:success] = "#{user.name}, you have successfully logged in as new user"
    else
      # Existing User
      flash[:welcome] = "Welcome back #{user.name}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end
  

  def logout
    session[:user_id] = nil
    flash[:success] = "Goodbye #{@current_user.name}"   
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
  
end

