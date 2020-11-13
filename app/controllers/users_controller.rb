class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
  @user = User.find_by(id: params[:id])
  if @user.nil?
    head :not_found
    return
  end
  end

  def new
    @user = User.new
  end

private

def user_params
  return params.require(:user).permit(:name)
end
end