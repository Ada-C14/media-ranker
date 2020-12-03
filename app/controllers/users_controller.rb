class UsersController < ApplicationController
  def index
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
    user = User.find_by(name: params[:user][:username])

    if user.nil?
      @user = User.new(name: params[:user][:username]) #using created_at instead of date joined
      if !@user.save
        flash[:error] = "Login failed: #{@user.name}"
        render :login_form
        return
      end
      flash[:success] = "Logged in as new user: #{@user.name}"
      session[:user_id] = @user.id
    else
      flash[:success] = "Logged in as returning user: #{user.name}"
      session[:user_id] = user.id

    end
    redirect_to root_path
    return
  end

  def logout
    @current_user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    redirect_to root_path
  end
end

