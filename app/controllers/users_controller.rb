class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:username])

    if @user.nil?
      @user = User.new(users_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        render :login_form
        return
      end
    else
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
    end

    redirect_to root_path
    return
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      if user
        session[:user_id] = nil
        flash[:notice] = "Successfully logged out"
      else
        session[:user_id] = nil
        flash[:error] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to log out"
    end
    redirect_to root_path
  end

  def show
    @user = User.find_by(id: params[:id].to_i)

    if @user.nil?
      head :not_found
      return
    end
  end

  private

  def users_params
    return params.require(:user).permit(:username)
  end
end
