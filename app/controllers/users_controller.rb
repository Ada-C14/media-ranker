class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
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
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as a new user #{username}"
      else
        flash[:error] = ["A problem occured: Could not log in"]
        flash[:error] << user.format_errors
        render :login_form
        return
      end
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

  #private
  #
  # def user_params
  #   return params.require(:user).permit(:username)
  # end
end
