class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    return :not_found if @user.nil?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.title} was successfully added!"
      redirect_to User_path(@user.id)
      return
    else
      flash.now[:error] = "#{@user.title} was not successfully added!"
      render :new, status: :bad_request
      return
    end

  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
