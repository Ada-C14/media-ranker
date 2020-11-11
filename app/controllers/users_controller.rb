class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      redirect_to root_path
      return
    else
      flash.now[:error] = "A problem occurred: Could not log in"
      render :login
      return
    end
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
