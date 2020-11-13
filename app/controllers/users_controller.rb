class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(user_params)

    if @user.nil?
      @user = User.new(user_params)
      flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
    elsif @user
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    else
      flash.now[:warning] = "Something went wrong 😱...let's try again 😊:"
      render :login_form
      return
    end

    session[:user_id] = @user.id
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

def user_params
  return params.require(:user).permit(:name)
end