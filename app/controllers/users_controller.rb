class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)

    if @user.nil?
      redirect_to users_path
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
      flash[:success] = "Successfully logged in as existing user #{@user.name}"
      redirect_to root_path
      return
    else
      @user = User.new(user_params)

      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as new user #{@user.name}"
        redirect_to root_path
        return
      else
        flash.now[:warning] = "A problem occurred: Could not log in"
        render :login_form, status: :bad_request
        return
      end
    end
  end

  def current
    @current_user = User.find_by(id: session[:user_id])

    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

  def user_params
    return params.require(:user).permit(:name)
  end
end
