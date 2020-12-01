class UsersController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:name]
    user = User.find_by(name: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(name: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
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
      flash[:error] = "Please log in as a new or returning user."
      redirect_to root_path
      return
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to root_path
      return
    end
    @votes = @user.votes.order(created_at: :desc)
  end

  @user = User.find_by(id: params[:id])
  render_404 unless @user

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
