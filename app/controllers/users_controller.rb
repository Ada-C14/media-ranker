class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must log in to view this page."
      redirect_to login_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    @user = User.find_by(name: name)
    if @user.nil?
      @user = User.create(name: name)
      if @user.valid?
        session[:user_id] = @user.id
        success_message = "Successfully created new user #{@user.name} with ID #{@user.id}"
        flash_success(success_message)
        redirect_to root_path
      else
        warning_message = "A problem occurred: Could not log in"
        flash_warning(warning_message, @user)

        render :login_form
      end
      return
    else
      session[:user_id] = @user.id
      success_message = "Successfully logged in as existing user #{@user.name} with ID #{@user.id}"
      flash_success(success_message)
      redirect_to root_path
      return
    end
  end

  def logout
    flash_success("Successfully logged out")
    session[:user_id] = nil
    redirect_to login_path
    return
  end
end