class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]

    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      session[:user_id] = @user.id
      session[:username] = @user.username
      flash[:success] = "Successfully logged in as existing user #{username}"
      redirect_to root_path
      return
    else
      @user = User.new(username: username)
      if @user.save
        session[:user_id] = @user.id
        session[:username] = @user.username
        flash[:success] = "Successfully created new user #{username} with ID #{@user.id}"
        redirect_to root_path
        return
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        render :login_form
        return
      end
    end
  end

  # def current
  #   @current_user = User.find_by(id: session[:user_id])
  #   unless @current_user
  #     flash[:error] = "A problem occurred: You must log in to do that"
  #     redirect_to root_path
  #     return
  #   end
  # end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      session[:username] = nil
      flash[:success] = "Successfully logged out"
      redirect_to root_path
      return
    else
      head :not_found
      return
    end
  end
end
