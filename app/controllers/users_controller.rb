class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path, status: :temporary_redirect
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      # new user
      user = User.new(name: params[:user][:name])
      if user.save
        flash[:success] = "Successfully created new user #{user.name} with ID: #{user.id}"
      else
        render :new, status: :bad_request and return
      end
    else
      # existing user
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    end

    session[:user_id] = user.id
    redirect_to user_path(session[:user_id])
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:success] = 'Successfully logged out'
      else
        session[:user_id] = nil
        flash[:notice] = 'ERROR unknown user'
      end
    else
      flash[:error] = 'You must be logged in to log out'
      redirect_to root_path
      return
    end

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])

    unless @current_user
      flash[:error] = "You must be logged in to vote"
      redirect_back(fallback_location: root_path)
      return
    end
  end

  private
  def user_params
    return params.require(:user).permit(:name)
  end


end
