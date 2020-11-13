class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end
  end
  
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{ username }"
      redirect_to root_path
      return
    end

    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully created new user #{ @user.username } with ID #{ @user.id }"
      redirect_to root_path
      return
    else
      flash.now[:error] = "A problem occurred: Could not log in"
      render :login_form, status: :bad_request 
      return
    end
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
      flash[:error] = "A problem occured: You must log in to do that"
      redirect_to root_path
      return
    end
  end

  private
  def user_params
    return params.require(:user).permit(:username, :joined).tap { |user| user[:joined] = Time.now.strftime("%b %d, %Y") }
  end
end
