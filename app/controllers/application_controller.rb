class ApplicationController < ActionController::Base
  def current_user
    if session[:user_id]
      return User.find_by(id: session[:user_id])
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "Please log in to vote."
      redirect_to login_path
    end
  end
end
