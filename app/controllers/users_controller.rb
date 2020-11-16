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
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :login_form, status: :bad_request
    end
  end


  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
