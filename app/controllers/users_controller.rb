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

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      user = User.new(name: params[:user][:name])
      if ! user.save
        flash[:error] = "Unable to login"
        redirect_to root_path
        return
      end
      flash[:welcome] = "Welcome #{user.name}"
    else
      flash[:welcome] = "Welcome back #{user.name}"
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(name: params[:user][:name])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodbye #{user.name}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error: Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
      return
    end
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
