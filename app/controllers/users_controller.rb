class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path, status: :temporary_redirect
      return
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "#{@user.name} was successfully added!"
      redirect_to user_path(@user.id)
      return
    else
      flash.now[:error] = "A problem occurred: could not create user"
      render :new, status: :bad_request
      return
    end
  end


  private
  def user_params
    return params.require(:user).permit(:name)
  end


end
