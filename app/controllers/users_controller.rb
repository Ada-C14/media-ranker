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

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(user_params)

    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{@user.username}"
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as new user #{@user.username}"
      else
        render :login_form
        return
      end
    end

    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end


end
