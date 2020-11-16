class ApplicationController < ActionController::Base

  def current_user
    @current_user = User.find_by(id: session[:user_id])
    return @current_user
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to do this"
      redirect_to login_path
    end
  end
end
