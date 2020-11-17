class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      # Change this to a 404 page
      redirect_to root
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have joined the ranker!"
      # @user or @user.id ?
      redirect_to user_path(@user.id)
      return
    else
      flash.now[:error] = "There's been an error. We couldn't add you to the system."
      render :new, status: :bad_request
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:user_name]
    user = User.find_by(user_name: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(user_name: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully signed up as new user #{username}"
    end

    redirect_to root_path
    return
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must log in to vote"
      redirect_to root_path
      return
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
    return
  end

  private

  def user_params
    return params.require(:user).permit(:user_name, :join_date)
  end

end
