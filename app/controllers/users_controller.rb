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
      flash[:error] = "You must be logged in to vote"
      redirect_to root_path
      return
    end
  end

  def index
    @users = User.all
  end

  def show
    if @work.nil?
      redirect_to works_path
      return
    end
  end
  #
  # def new
  #   @user = User.new
  # end
  #
  # def create
  #   @user = User.new(user_params)
  #
  #   if @user.save
  #     flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
  #     redirect_to root_path
  #     return
  #   else
  #     flash.now[:error] = "Something happened. User not added."
  #     render :new, status: :bad_request
  #     return
  #   end
  # end
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end
  #


  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
