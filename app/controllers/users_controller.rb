class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to root_path
      return
    end
  end

  # def new
  #   @user = User.new
  # end
  #
  # def create
  #   @user = User.new(users_param)
  #
  #   if @user.save
  #     redirect_to root_path
  #     return
  #   else
  #     render :new
  #   end
  # end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])

    if @user.nil?
      @user = User.create(username: params[:user][:username])
      unless @user.save
        flash[:error] = "Unable to log in."
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{@user.username}!"
    else
      flash[:welcome] = "Welcome back #{@user.username}"
    end
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      unless @user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{@user.username}!"
      else
        session[:user_id] = nil
        flash[:notice] = "Unknown User."
      end
    else
      flash[:error] = "You must be logged in first to logout."
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
  end

  # private
  #
  # def users_param
  #   return params.require(:user).permit(:id, :username)
  # end
end
