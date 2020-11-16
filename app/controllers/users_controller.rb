class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "User not found"
      redirect_to root_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as returning user #{@user.username}"
    else
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Successfully logged in as new user #{@user.username}"
      else
        flash.now[:error] = "Unable to login"
        render :login_form
      end
    end

    redirect_to root_path
    return
  end

  def logout

  end


  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
