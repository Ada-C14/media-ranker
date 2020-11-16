class ApplicationController < ActionController::Base

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to perform this action."
      redirect_to login_path
      return
    end
  end

end
