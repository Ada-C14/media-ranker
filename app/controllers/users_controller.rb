class UsersController < ApplicationController
  def index
    # @users = User.order(date_joined :asc)
    @user = User.all
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
    name = params[:user][:name] #user input
    user = User.find_by(name: name)

    if !user.nil?
      session[:user_id] = user.id #setting the session id to the user_id
      flash[:success] = "Successfully logged in as returning user #{name}"
    else
      user = User.create(name: name)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{name}"
    end
    redirect_to root_path
    return
  end

  # def current
  #   @current_user = User.find_by(id: session[:user_id])
  #
  #   if @current_user.nil?
  #     flash[:error] = "You must be logged in to see this page"
  #     redirect_to root_path
  #     return
  #   end
  # end
end


