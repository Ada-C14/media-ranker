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

    if @user.nil?
      @user = User.new(user_params)
      if @user.save
        flash[:welcome] = "Welcome #{@user.username}"
      else
        flash[:error] = "Unable to login"
        redirect_to root_path
        return
      end
    else
      flash[:welcome] = "Welcome back #{@user.username}"
    end

    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout

  end


  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
