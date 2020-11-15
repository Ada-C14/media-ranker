class UsersController < ApplicationController
  def index
    @users = User.all
    @votes = Vote.all
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} was successfully created :)"
      redirect_to user_path(@user.id)
      return
    else
      flash.now[:error] = "#{@user.name} was NOT successfully added :("
      render :new
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(user_params)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{user.name}"
    else
      @user = User.new(name: params[:user][:name])
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully logged in as new user #{@user.name}"
      else
        flash[:error] = "Unable to create #{@user.name}"
        render :login_form
        return
      end
    end
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
    render :show
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      if user
        flash[:notice] = "Goodbye #{user.name}"
      else
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be Logged In to Logout"
    end
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def user_params
    return params.require(:user).permit(:name)
  end

end
