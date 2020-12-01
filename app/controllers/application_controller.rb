class ApplicationController < ActionController::Base

  before_action :find_user

  # def current_user
  #   # find out who current user is
  #   @current_user = User.find_by(id: session[:user_id])
  # end

  def require_login
    # call current_user
    # if output is nil then set error session variable and redirect
    if find_user.nil?
      flash[:error] = "You must be logged in to do that"
      redirect_to login_path
    end
  end

  private

  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
